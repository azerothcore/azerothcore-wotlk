/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "utgarde_keep.h"

enum eDisplayId
{
    DISPLAYID_DEFAULT               = 21953,
    DISPLAYID_UNDEAD                = 26351,
};

enum eNPCs
{
    NPC_INGVAR_UNDEAD               = 23980,
    NPC_ANNHYLDE                    = 24068,
    NPC_THROW                       = 23997,
};

enum Yells
{
    //Yells Ingvar
    YELL_AGGRO_1                                = 0,
    YELL_KILL_1                                 = 1,
    YELL_DEAD_1                                 = 2,

    YELL_AGGRO_2                                = 3,
    YELL_KILL_2                                 = 4,
    YELL_DEAD_2                                 = 5,

    EMOTE_ROAR                                  = 6,
    YELL_ANHYLDE_1                              = 0,
    YELL_ANHYLDE_2                              = 1,
};

enum eSpells
{
    SPELL_SUMMON_VALKYR             = 42912,
    SPELL_RESURRECTION_BEAM         = 42857,
    SPELL_RESURRECTION_BALL         = 42862,
    SPELL_RESURRECTION_HEAL         = 42704,
    SPELL_INGVAR_TRANSFORM          = 42796,

    SPELL_STAGGERING_ROAR_N         = 42708,
    SPELL_STAGGERING_ROAR_H         = 59708,
    SPELL_CLEAVE                    = 42724,
    SPELL_SMASH_N                   = 42669,
    SPELL_SMASH_H                   = 59706,
    SPELL_ENRAGE_N                  = 42705,
    SPELL_ENRAGE_H                  = 59707,

    SPELL_DREADFUL_ROAR_N           = 42729,
    SPELL_DREADFUL_ROAR_H           = 59734,
    SPELL_WOE_STRIKE_N              = 42730,
    SPELL_WOE_STRIKE_H              = 59735,
    SPELL_DARK_SMASH                = 42723,
    SPELL_SHADOW_AXE                = 42749,
};

#define SPELL_STAGGERING_ROAR       DUNGEON_MODE(SPELL_STAGGERING_ROAR_N, SPELL_STAGGERING_ROAR_H)
#define SPELL_DREADFUL_ROAR         DUNGEON_MODE(SPELL_DREADFUL_ROAR_N, SPELL_DREADFUL_ROAR_H)
#define SPELL_WOE_STRIKE            DUNGEON_MODE(SPELL_WOE_STRIKE_N, SPELL_WOE_STRIKE_H)
#define SPELL_SMASH                 DUNGEON_MODE(SPELL_SMASH_N, SPELL_SMASH_H)
#define SPELL_ENRAGE                DUNGEON_MODE(SPELL_ENRAGE_N, SPELL_ENRAGE_H)

enum eEvents
{
    EVENT_START_RESURRECTION = 1,
    EVENT_YELL_DEAD_1,
    EVENT_VALKYR_MOVE,
    EVENT_ANNHYLDE_YELL,
    EVENT_VALKYR_BEAM,
    EVENT_RESURRECTION_BALL,
    EVENT_RESURRECTION_HEAL,
    EVENT_MORPH_TO_UNDEAD,
    EVENT_START_PHASE_2,

    EVENT_UNROOT,
    EVENT_SPELL_ROAR,
    EVENT_SPELL_CLEAVE_OR_WOE_STRIKE,
    EVENT_SPELL_SMASH,
    EVENT_SPELL_ENRAGE_OR_SHADOW_AXE,
    EVENT_AXE_RETURN,
    EVENT_AXE_PICKUP,
};

class boss_ingvar_the_plunderer : public CreatureScript
{
public:
    boss_ingvar_the_plunderer() : CreatureScript("boss_ingvar_the_plunderer") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_ingvar_the_plundererAI(pCreature);
    }

    struct boss_ingvar_the_plundererAI : public ScriptedAI
    {
        boss_ingvar_the_plundererAI(Creature *c) : ScriptedAI(c), summons(me)
        {
            pInstance = c->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;
        SummonList summons;
        uint64 ValkyrGUID;
        uint64 ThrowGUID;

        void Reset()
        {
            ValkyrGUID = 0;
            ThrowGUID = 0;
            events.Reset();
            summons.DespawnAll();
            me->SetDisplayId(DISPLAYID_DEFAULT);
            me->LoadEquipment(1);
            FeignDeath(false);
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
            me->SetControlled(false, UNIT_STATE_ROOT);
            me->DisableRotate(false);

            if (pInstance)
                pInstance->SetData(DATA_INGVAR, NOT_STARTED);
        }

        void DamageTaken(Unit*, uint32 &damage, DamageEffectType, SpellSchoolMask)
        {
            if (me->GetDisplayId() == DISPLAYID_DEFAULT && damage >= me->GetHealth())
            {
                damage = 0;
                me->InterruptNonMeleeSpells(true);
                me->RemoveAllAuras();
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                me->SetControlled(false, UNIT_STATE_ROOT);
                me->DisableRotate(false);
                me->GetMotionMaster()->MovementExpired();
                me->GetMotionMaster()->MoveIdle();
                me->StopMoving();
                FeignDeath(true);
                events.Reset();
                events.RescheduleEvent(EVENT_START_RESURRECTION, 1000);
                events.RescheduleEvent(EVENT_YELL_DEAD_1, 0);
            }
        }

        void EnterCombat(Unit * /*who*/)
        {
            events.Reset();
            // schedule Phase 1 abilities
            events.RescheduleEvent(EVENT_SPELL_ROAR, 15000);
            events.RescheduleEvent(EVENT_SPELL_CLEAVE_OR_WOE_STRIKE, 2000);
            events.RescheduleEvent(EVENT_SPELL_SMASH, 5000);
            events.RescheduleEvent(EVENT_SPELL_ENRAGE_OR_SHADOW_AXE, 10000);

            Talk(YELL_AGGRO_1);
            me->LowerPlayerDamageReq(me->GetMaxHealth());

            if (pInstance)
                pInstance->SetData(DATA_INGVAR, IN_PROGRESS);
        }

        void JustSummoned(Creature* s)
        {
            summons.Summon(s);
            if (s->GetEntry() == NPC_ANNHYLDE)
            {
                ValkyrGUID = s->GetGUID();
                s->SetCanFly(true);
                s->SetDisableGravity(true);
                s->SetHover(true);
                s->SetPosition(s->GetPositionX(), s->GetPositionY(), s->GetPositionZ()+35.0f, s->GetOrientation());
                s->SetFacingTo(s->GetOrientation());
            }
            else if (s->GetEntry() == NPC_THROW)
            {
                ThrowGUID = s->GetGUID();
                if( Unit* t = SelectTarget(SELECT_TARGET_RANDOM, 0, 70.0f, true) )
                    s->GetMotionMaster()->MovePoint(0, t->GetPositionX(), t->GetPositionY(), t->GetPositionZ());
            }
        }

        void KilledUnit(Unit* /*who*/)
        {
            if (me->GetDisplayId() == DISPLAYID_DEFAULT)
                Talk(YELL_KILL_2);
            else
                Talk(YELL_KILL_1);
        }

        void FeignDeath(bool apply)
        {
            if (apply)
            {
                me->SetStandState(UNIT_STAND_STATE_DEAD);
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_UNK_29);
                me->SetFlag(UNIT_FIELD_FLAGS_2, UNIT_FLAG2_FEIGN_DEATH);
                me->SetFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_DEAD);
            }
            else
            {
                me->SetStandState(UNIT_STAND_STATE_STAND);
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_UNK_29);
                me->RemoveFlag(UNIT_FIELD_FLAGS_2, UNIT_FLAG2_FEIGN_DEATH);
                me->RemoveFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_DEAD);
            }
        }

        void JustDied(Unit* /*killer*/)
        {
            events.Reset();
            summons.DespawnAll();
            Talk(YELL_DEAD_2);
            if (pInstance)
            {
                pInstance->DoUpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_KILL_CREATURE, NPC_INGVAR_UNDEAD, 1); // undead entry needed for achievements
                pInstance->SetData(DATA_INGVAR, DONE);
            }
        }

        void EnterEvadeMode()
        {
            me->SetControlled(false, UNIT_STATE_ROOT);
            me->DisableRotate(false);
            ScriptedAI::EnterEvadeMode();
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if( me->HasUnitState(UNIT_STATE_CASTING) )
                return;

            switch( events.GetEvent() )
            {
                case 0:
                    break;
                case EVENT_YELL_DEAD_1:
                    Talk(YELL_DEAD_1);
                    events.PopEvent();
                    break;
                case EVENT_START_RESURRECTION:
                    me->CastSpell(me, SPELL_SUMMON_VALKYR, true);
                    events.PopEvent();
                    events.RescheduleEvent(EVENT_VALKYR_BEAM, 7000);
                    events.RescheduleEvent(EVENT_VALKYR_MOVE, 1);
                    events.RescheduleEvent(EVENT_ANNHYLDE_YELL, 3000);
                    break;
                case EVENT_VALKYR_MOVE:
                    if( Creature* s = ObjectAccessor::GetCreature(*me, ValkyrGUID) )
                        s->GetMotionMaster()->MovePoint(1, s->GetPositionX(), s->GetPositionY(), s->GetPositionZ()-15.0f);
                    events.PopEvent();
                    break;
                case EVENT_ANNHYLDE_YELL:
                    if( Creature* s = ObjectAccessor::GetCreature(*me, ValkyrGUID) )
                        s->AI()->Talk(YELL_ANHYLDE_2);
                    events.PopEvent();
                    break;
                case EVENT_VALKYR_BEAM:
                    me->RemoveAura(SPELL_SUMMON_VALKYR);
                    if( Creature* c = ObjectAccessor::GetCreature(*me, ValkyrGUID) )
                        c->CastSpell(me, SPELL_RESURRECTION_BEAM, false);
                    events.PopEvent();
                    events.RescheduleEvent(EVENT_RESURRECTION_BALL, 4000);
                    break;
                case EVENT_RESURRECTION_BALL:
                    me->CastSpell(me, SPELL_RESURRECTION_BALL, true);
                    events.PopEvent();
                    events.RescheduleEvent(EVENT_RESURRECTION_HEAL, 4000);
                    break;
                case EVENT_RESURRECTION_HEAL:
                    me->RemoveAura(SPELL_RESURRECTION_BALL);
                    me->CastSpell(me, SPELL_RESURRECTION_HEAL, true);
                    FeignDeath(false);
                    events.PopEvent();
                    events.RescheduleEvent(EVENT_MORPH_TO_UNDEAD, 3000);
                    break;
                case EVENT_MORPH_TO_UNDEAD:
                    me->CastSpell(me, SPELL_INGVAR_TRANSFORM, true);
                    events.PopEvent();
                    events.RescheduleEvent(EVENT_START_PHASE_2, 1000);
                    break;
                case EVENT_START_PHASE_2:
                    if( Creature* c = ObjectAccessor::GetCreature(*me, ValkyrGUID) )
                    {
                        c->DespawnOrUnsummon();
                        summons.DespawnAll();
                    }
                    events.PopEvent();
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                    AttackStart(me->GetVictim());
                    me->GetMotionMaster()->MoveChase(me->GetVictim());
                    Talk(YELL_AGGRO_2);

                    // schedule Phase 2 abilities
                    events.RescheduleEvent(EVENT_SPELL_ROAR, 15000);
                    events.RescheduleEvent(EVENT_SPELL_CLEAVE_OR_WOE_STRIKE, 2000);
                    events.RescheduleEvent(EVENT_SPELL_SMASH, 5000);
                    events.RescheduleEvent(EVENT_SPELL_ENRAGE_OR_SHADOW_AXE, 10000);

                    break;

                // ABILITIES HERE:
                case EVENT_UNROOT:
                    me->SetControlled(false, UNIT_STATE_ROOT);
                    me->DisableRotate(false);
                    events.PopEvent();
                    break;
                case EVENT_SPELL_ROAR:
                    Talk(EMOTE_ROAR);

                    me->_AddCreatureSpellCooldown(SPELL_STAGGERING_ROAR, 0);
                    me->_AddCreatureSpellCooldown(SPELL_DREADFUL_ROAR, 0);

                    if (me->GetDisplayId() == DISPLAYID_DEFAULT)
                        me->CastSpell((Unit*)NULL, SPELL_STAGGERING_ROAR, false);
                    else
                        me->CastSpell((Unit*)NULL, SPELL_DREADFUL_ROAR, false);
                    events.RepeatEvent(urand(15000,20000));
                    break;
                case EVENT_SPELL_CLEAVE_OR_WOE_STRIKE:
                    if( me->GetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID) == 0 )
                    {
                        events.RepeatEvent(3000);
                        break;
                    }
                    if (me->GetDisplayId() == DISPLAYID_DEFAULT)
                        me->CastSpell(me->GetVictim(), SPELL_CLEAVE, false);
                    else
                        me->CastSpell(me->GetVictim(), SPELL_WOE_STRIKE, false);
                    events.RepeatEvent(urand(0,4000)+3000);
                    break;
                case EVENT_SPELL_SMASH:
                    if( me->GetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID) == 0 )
                    {
                        events.RepeatEvent(3000);
                        break;
                    }
                    me->SetControlled(true, UNIT_STATE_ROOT);
                    me->DisableRotate(true);
                    me->SendMovementFlagUpdate();
                    if (me->GetDisplayId() == DISPLAYID_DEFAULT)
                        me->CastSpell((Unit*)NULL, SPELL_SMASH, false);
                    else
                        me->CastSpell((Unit*)NULL, SPELL_DARK_SMASH, false);
                    events.RepeatEvent(urand(9000,11000));
                    events.RescheduleEvent(EVENT_UNROOT, 3750);
                    break;
                case EVENT_SPELL_ENRAGE_OR_SHADOW_AXE:
                    if (me->GetDisplayId() == DISPLAYID_DEFAULT)
                    {
                        me->CastSpell(me, SPELL_ENRAGE, false);
                        events.RepeatEvent(10000);
                    }
                    else
                    {
                        me->CastSpell((Unit*)NULL, SPELL_SHADOW_AXE, true);
                        SetEquipmentSlots(false, EQUIP_UNEQUIP, EQUIP_NO_CHANGE, EQUIP_NO_CHANGE);
                        events.RepeatEvent(35000);
                        events.RescheduleEvent(EVENT_AXE_RETURN, 10000);
                    }
                    break;
                case EVENT_AXE_RETURN:
                    if (Creature* c = ObjectAccessor::GetCreature(*me, ThrowGUID))
                        c->GetMotionMaster()->MoveCharge(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()+0.5f);
                    events.PopEvent();
                    events.RescheduleEvent(EVENT_AXE_PICKUP, 1500);
                    break;
                case EVENT_AXE_PICKUP:
                    if (Creature* c = ObjectAccessor::GetCreature(*me, ThrowGUID))
                    {
                        c->DestroyForNearbyPlayers();
                        c->DespawnOrUnsummon();
                        summons.DespawnAll();
                    }
                    ThrowGUID = 0;
                    SetEquipmentSlots(true);
                    events.PopEvent();
                    break;
            }

            if (!me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE))
                DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_ingvar_the_plunderer()
{
    new boss_ingvar_the_plunderer();
}
