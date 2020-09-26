/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "sunwell_plateau.h"
#include "MoveSplineInit.h"
#include "CreatureTextMgr.h"

enum Yells
{
    SAY_KJ_OFFCOMBAT                            = 0,

    SAY_KALECGOS_ENCOURAGE                      = 0,
    SAY_KALECGOS_READY1                         = 1,
    SAY_KALECGOS_READY2                         = 2,
    SAY_KALECGOS_READY_ALL                      = 3,
    SAY_KALECGOS_AWAKEN                         = 5,
    SAY_KALECGOS_LETGO                          = 6,
    SAY_KALECGOS_FOCUS                          = 7,
    SAY_KALECGOS_FATE                           = 8,
    SAY_KALECGOS_GOODBYE                        = 9,
    SAY_KALECGOS_JOIN                           = 10,

    SAY_KJ_DEATH                                = 0,
    SAY_KJ_SLAY                                 = 1,
    SAY_KJ_REFLECTION                           = 2,
    SAY_KJ_EMERGE                               = 3,
    SAY_KJ_DARKNESS                             = 4,
    SAY_KJ_PHASE3                               = 5,
    SAY_KJ_PHASE4                               = 6,
    SAY_KJ_PHASE5                               = 7,
    EMOTE_KJ_DARKNESS                           = 8,

    SAY_ANVEENA_IMPRISONED                      = 0,
    SAY_ANVEENA_LOST                            = 1,
    SAY_ANVEENA_KALEC                           = 2,
    SAY_ANVEENA_GOODBYE                         = 3
};

enum Spells
{
    // Kil'jaeden spells
    SPELL_REBIRTH                               = 44200,
    SPELL_SOUL_FLAY                             = 45442,
    SPELL_LEGION_LIGHTNING                      = 45664,
    SPELL_FIRE_BLOOM                            = 45641,
    SPELL_SHADOW_SPIKE                          = 46680,
    SPELL_SINISTER_REFLECTION                   = 45892,
    SPELL_FLAME_DART                            = 45737,
    SPELL_FLAME_DART_EXPLOSION                  = 45746,
    SPELL_DARKNESS_OF_A_THOUSAND_SOULS          = 46605,
    SPELL_DARKNESS_OF_A_THOUSAND_SOULS_DAMAGE   = 45657,
    SPELL_ARMAGEDDON_PERIODIC                   = 45921,
    SPELL_ARMAGEDDON_VISUAL                     = 45911,
    SPELL_ARMAGEDDON_MISSILE                    = 45909,
    SPELL_CUSTOM_08_STATE                       = 45800,
    SPELL_DESTROY_ALL_DRAKES                    = 46707,

    // Sinister Reflections
    SPELL_SINISTER_REFLECTION_SUMMON            = 45891,
    SPELL_SINISTER_REFLECTION_CLASS             = 45893,
    SPELL_SINISTER_REFLECTION_CLONE             = 45785,

    // Misc
    SPELL_ANVEENA_ENERGY_DRAIN                  = 46410,
    SPELL_RING_OF_BLUE_FLAMES                   = 45825,
    SPELL_SUMMON_BLUE_DRAKE                     = 45836,
    SPELL_VENGEANCE_OF_THE_BLUE_FLIGHT          = 45839,
    SPELL_POSSESS_DRAKE_IMMUNITY                = 45838,
    SPELL_SACRIFICE_OF_ANVEENA                  = 46474,
};

enum Misc
{
    PHASE_DECEIVERS                 = 1,
    PHASE_NORMAL                    = 2,
    PHASE_DARKNESS                  = 3,
    PHASE_ARMAGEDDON                = 4,
    PHASE_SACRIFICE                 = 5,

    EVENT_GROUP_SPEACH              = 1,
    ACTION_START_POST_EVENT         = 1,
    ACTION_NO_KILL_TALK             = 2,

    // Text events
    EVENT_TEXT_SPEACH11             = 1,
    EVENT_TEXT_SPEACH21             = 2,
    EVENT_TEXT_SPEACH22             = 3,
    EVENT_TEXT_SPEACH23             = 4,
    EVENT_TEXT_SPEACH31             = 5,
    EVENT_TEXT_SPEACH32             = 6,
    EVENT_TEXT_SPEACH33             = 7,
    EVENT_TEXT_SPEACH41             = 8,
    EVENT_TEXT_SPEACH42             = 9,
    EVENT_TEXT_SPEACH43             = 10,
    EVENT_TEXT_SPEACH44             = 11,
    EVENT_TEXT_SPEACH45             = 12,
    EVENT_TEXT_SPEACH46             = 13,

    // Controller events
    EVENT_RANDOM_TALK               = 40,
    EVENT_CHECK_PLAYERS             = 41,

    // Misc fight events
    EVENT_REBIRTH                   = 50,
    EVENT_INIT_FIGHT                = 51,
    EVENT_CHECK_HEALTH85            = 52,
    EVENT_CHECK_HEALTH55            = 53,
    EVENT_CHECK_HEALTH25            = 54,
    EVENT_EMPOWER_ORBS1             = 55,
    EVENT_EMPOWER_ORBS2             = 56,
    EVENT_EMPOWER_ORBS3             = 57,
    EVENT_RESTORE_MELEE             = 58,
    EVENT_KILL_SELF                 = 59,
    EVENT_NO_KILL_TALK              = 60,

    // Abilities events
    EVENT_SPELL_SOUL_FLAY           = 100,
    EVENT_SPELL_LEGION_LIGHTNING    = 101,
    EVENT_SPELL_FIRE_BLOOM          = 102,
    EVENT_SUMMON_ORBS               = 103,
    EVENT_SPELL_SHADOW_SPIKE        = 104,
    EVENT_SPELL_SINISTER_REFLECTION = 105,
    EVENT_SPELL_FLAME_DART          = 106,
    EVENT_SPELL_DARKNESS            = 107,
    EVENT_SPELL_ARMAGEDDON          = 108,
};

class CastArmageddon : public BasicEvent
{
    public:
        CastArmageddon(Creature* caster) : _caster(caster)
        {
        }

        bool Execute(uint64 /*execTime*/, uint32 /*diff*/)
        {
            _caster->CastSpell(_caster, SPELL_ARMAGEDDON_MISSILE, true);
            _caster->SetPosition(_caster->GetPositionX(), _caster->GetPositionY(), _caster->GetPositionZ()-20.0f, 0.0f);
            return true;
        }

    private:
        Creature* _caster;
};

class npc_kiljaeden_controller : public CreatureScript
{
public:
    npc_kiljaeden_controller() : CreatureScript("npc_kiljaeden_controller") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return GetInstanceAI<npc_kiljaeden_controllerAI>(creature);
    }

    struct npc_kiljaeden_controllerAI : public NullCreatureAI
    {
        npc_kiljaeden_controllerAI(Creature* creature) : NullCreatureAI(creature), summons(me)
        {
            instance = creature->GetInstanceScript();
        }

        EventMap events;
        InstanceScript* instance;
        SummonList summons;

        void ResetOrbs()
        {
            for (uint8 i = 0; i < 4; ++i)
                if (GameObject* orb = ObjectAccessor::GetGameObject(*me, instance->GetData64(DATA_ORB_OF_THE_BLUE_DRAGONFLIGHT_1+i)))
                    orb->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
        }

        void Reset()
        {
            instance->SetBossState(DATA_KILJAEDEN, NOT_STARTED);
            events.Reset();
            summons.DespawnAll();
            ResetOrbs();

            me->SummonCreature(NPC_HAND_OF_THE_DECEIVER, 1702.62f, 611.19f, 27.66f, 1.81f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30000);
            me->SummonCreature(NPC_HAND_OF_THE_DECEIVER, 1684.099f, 618.848f, 27.67f, 0.589f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30000);
            me->SummonCreature(NPC_HAND_OF_THE_DECEIVER, 1688.38f, 641.10f, 27.50f, 5.43f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30000);
            me->SummonCreature(NPC_ANVEENA, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()+40.0f, 0.0f);

            me->CastSpell(me, SPELL_DESTROY_ALL_DRAKES, true);
            me->CastSpell(me, SPELL_ANVEENA_ENERGY_DRAIN, true);
            events.ScheduleEvent(EVENT_RANDOM_TALK, 60000);
        }

        void JustDied(Unit*)
        {
            EntryCheckPredicate kilCheck(NPC_KILJAEDEN);
            EntryCheckPredicate kalCheck(NPC_KALECGOS_KJ);
            summons.DespawnIf(kilCheck);
            summons.DoAction(ACTION_START_POST_EVENT, kalCheck);
            summons.DespawnIf(kalCheck);

            me->CastSpell(me, SPELL_DESTROY_ALL_DRAKES, true);
            summons.DespawnAll();
        }

        void JustSummoned(Creature* summon)
        {
            summons.Summon(summon);
            if (summon->GetEntry() == NPC_SINISTER_REFLECTION)
                summon->SetInCombatWithZone();
            else if (summon->GetEntry() == NPC_KALECGOS_KJ)
                summon->setActive(true);
        }

        void SummonedCreatureDies(Creature* summon, Unit*)
        {
            summons.Despawn(summon);

            if (summon->GetEntry() == NPC_HAND_OF_THE_DECEIVER)
            {
                instance->SetBossState(DATA_KILJAEDEN, IN_PROGRESS);
                events.ScheduleEvent(EVENT_CHECK_PLAYERS, 1000);

                if (!summons.HasEntry(NPC_HAND_OF_THE_DECEIVER))
                {
                    me->RemoveAurasDueToSpell(SPELL_ANVEENA_ENERGY_DRAIN);
                    me->SummonCreature(NPC_KILJAEDEN, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()+1.5f, 4.3f, TEMPSUMMON_MANUAL_DESPAWN);
                    me->SummonCreature(NPC_KALECGOS_KJ, 1726.80f, 661.43f, 138.65f, 3.95f, TEMPSUMMON_MANUAL_DESPAWN);
                }
            }
        }

        void UpdateAI(uint32 diff)
        {
            events.Update(diff);
            switch (events.ExecuteEvent())
            {
                case EVENT_RANDOM_TALK:
                    if (instance->GetBossState(DATA_KILJAEDEN) == NOT_STARTED)
                        Talk(SAY_KJ_OFFCOMBAT);
                    events.ScheduleEvent(EVENT_RANDOM_TALK, urand(90000, 180000));
                    break;
                case EVENT_CHECK_PLAYERS:
                {
                    Map::PlayerList const& players = me->GetMap()->GetPlayers();
                    for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                        if (Player* player = itr->GetSource())
                            if (!player->IsGameMaster() && me->GetDistance2d(player) < 60.0f && player->IsAlive())
                            {
                                events.ScheduleEvent(EVENT_CHECK_PLAYERS, 1000);
                                return;
                            }

                    CreatureAI::EnterEvadeMode();
                    break;
                }
            }
        }
    };
};

class boss_kiljaeden : public CreatureScript
{
public:
    boss_kiljaeden() : CreatureScript("boss_kiljaeden") { }

    struct boss_kiljaedenAI : public ScriptedAI
    {
        boss_kiljaedenAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = creature->GetInstanceScript();
            me->SetReactState(REACT_PASSIVE);
        }

        InstanceScript* instance;
        EventMap events;
        EventMap events2;
        uint8 phase;

        void InitializeAI()
        {
            ScriptedAI::InitializeAI();
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);

            phase = PHASE_NORMAL;
            events.Reset();
            events2.Reset();
            events2.ScheduleEvent(EVENT_INIT_FIGHT, 11000);
            events2.ScheduleEvent(EVENT_REBIRTH, 0);
            me->SetVisible(false);
        }

        void Reset()
        {
            events.Reset();
        }

        void EnterEvadeMode()
        {
            if (me->GetReactState() == REACT_PASSIVE)
                return;
            ScriptedAI::EnterEvadeMode();
        }

        void AttackStart(Unit* who)
        {
            if (me->GetReactState() == REACT_PASSIVE)
                return;
            ScriptedAI::AttackStart(who);
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask)
        {
            if (damage >= me->GetHealth())
            {
                me->SetTarget(0);
                me->SetReactState(REACT_PASSIVE);
                me->RemoveAllAuras();
                me->DeleteThreatList();
                me->SetRegeneratingHealth(false);
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                me->HandleEmoteCommand(EMOTE_ONESHOT_DROWN);
                me->resetAttackTimer();
                events.Reset();
                events2.Reset();
                events2.ScheduleEvent(EVENT_KILL_SELF, 500);
                damage = 0;
            }
        }

        void JustDied(Unit* /*killer*/)
        {
            Talk(SAY_KJ_DEATH);
            instance->SetBossState(DATA_KILJAEDEN, DONE);
            if (Creature* controller = ObjectAccessor::GetCreature(*me, instance->GetData64(NPC_KILJAEDEN_CONTROLLER)))
                Unit::Kill(controller, controller);
        }

        void DoAction(int32 param)
        {
            if (param == ACTION_NO_KILL_TALK)
            {
                events.ScheduleEvent(EVENT_NO_KILL_TALK, 0);
                Talk(SAY_KJ_DARKNESS);
            }
        }

        void KilledUnit(Unit* victim)
        {
            if (victim->GetTypeId() == TYPEID_PLAYER && events.GetNextEventTime(EVENT_NO_KILL_TALK) == 0)
                Talk(SAY_KJ_SLAY);
        }

        void EnterCombat(Unit* /*who*/)
        {
            events2.ScheduleEvent(EVENT_TEXT_SPEACH11, 26000, EVENT_GROUP_SPEACH);
            Talk(SAY_KJ_EMERGE);

            events.SetTimer(200000);
            events.ScheduleEvent(EVENT_CHECK_HEALTH85, 1000);
            events.ScheduleEvent(EVENT_CHECK_HEALTH55, 1000);
            events.ScheduleEvent(EVENT_CHECK_HEALTH25, 1000);
            events.ScheduleEvent(EVENT_SPELL_SOUL_FLAY, 0);
            events.ScheduleEvent(EVENT_SPELL_LEGION_LIGHTNING, 7000);
            events.ScheduleEvent(EVENT_SPELL_FIRE_BLOOM, 9000);
            events.ScheduleEvent(EVENT_SUMMON_ORBS, 10000);
        }

        void JustSummoned(Creature* summon)
        {
            if (summon->GetEntry() == NPC_ARMAGEDDON_TARGET)
            {
                summon->SetDisableGravity(true);
                summon->SetCanFly(true);
                summon->CastSpell(summon, SPELL_ARMAGEDDON_VISUAL, true);
                summon->SetPosition(summon->GetPositionX(), summon->GetPositionY(), summon->GetPositionZ()+20.0f, 0.0f);
                summon->m_Events.AddEvent(new CastArmageddon(summon), summon->m_Events.CalculateTime(6000));
                summon->DespawnOrUnsummon(10000);
            }
        }

        void UpdateAI(uint32 diff)
        {
            events2.Update(diff);
            switch (events2.ExecuteEvent())
            {
                case EVENT_KILL_SELF:
                    Unit::Kill(me, me);
                    break;
                case EVENT_REBIRTH:
                    me->SetVisible(true);
                    me->CastSpell(me, SPELL_REBIRTH, false);
                    break;
                case EVENT_EMPOWER_ORBS1:
                    if (Creature* kalec = ObjectAccessor::GetCreature(*me, instance->GetData64(NPC_KALECGOS_KJ)))
                        kalec->AI()->Talk(SAY_KALECGOS_READY1);
                    EmpowerOrb(false);
                    break;
                case EVENT_EMPOWER_ORBS2:
                    if (Creature* kalec = ObjectAccessor::GetCreature(*me, instance->GetData64(NPC_KALECGOS_KJ)))
                        kalec->AI()->Talk(SAY_KALECGOS_READY2);
                    EmpowerOrb(false);
                    break;
                case EVENT_EMPOWER_ORBS3:
                    if (Creature* kalec = ObjectAccessor::GetCreature(*me, instance->GetData64(NPC_KALECGOS_KJ)))
                        kalec->AI()->Talk(SAY_KALECGOS_READY_ALL);
                    EmpowerOrb(true);
                    break;
                case EVENT_INIT_FIGHT:
                    me->SetReactState(REACT_AGGRESSIVE);
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                    me->SetInCombatWithZone();
                    return;
                case EVENT_TEXT_SPEACH11:
                    if (Creature* kalec = ObjectAccessor::GetCreature(*me, instance->GetData64(NPC_KALECGOS_KJ)))
                        kalec->AI()->Talk(SAY_KALECGOS_JOIN);
                    break;
                case EVENT_TEXT_SPEACH21:
                    if (Creature* kalec = ObjectAccessor::GetCreature(*me, instance->GetData64(NPC_KALECGOS_KJ)))
                        kalec->AI()->Talk(SAY_KALECGOS_AWAKEN);
                    break;
                case EVENT_TEXT_SPEACH22:
                    if (Creature* anveena = ObjectAccessor::GetCreature(*me, instance->GetData64(NPC_ANVEENA)))
                        sCreatureTextMgr->SendChat(anveena, SAY_ANVEENA_IMPRISONED, NULL, CHAT_MSG_ADDON, LANG_ADDON, TEXT_RANGE_ZONE);
                    break;
                case EVENT_TEXT_SPEACH23:
                    Talk(SAY_KJ_PHASE3);
                    break;
                case EVENT_TEXT_SPEACH31:
                    if (Creature* kalec = ObjectAccessor::GetCreature(*me, instance->GetData64(NPC_KALECGOS_KJ)))
                        kalec->AI()->Talk(SAY_KALECGOS_LETGO);
                    break;
                case EVENT_TEXT_SPEACH32:
                    if (Creature* anveena = ObjectAccessor::GetCreature(*me, instance->GetData64(NPC_ANVEENA)))
                        sCreatureTextMgr->SendChat(anveena, SAY_ANVEENA_LOST, NULL, CHAT_MSG_ADDON, LANG_ADDON, TEXT_RANGE_ZONE);
                    break;
                case EVENT_TEXT_SPEACH33:
                    Talk(SAY_KJ_PHASE4);
                    break;
                case EVENT_TEXT_SPEACH41:
                    if (Creature* kalec = ObjectAccessor::GetCreature(*me, instance->GetData64(NPC_KALECGOS_KJ)))
                        kalec->AI()->Talk(SAY_KALECGOS_FOCUS);
                    break;
                case EVENT_TEXT_SPEACH42:
                    if (Creature* anveena = ObjectAccessor::GetCreature(*me, instance->GetData64(NPC_ANVEENA)))
                        sCreatureTextMgr->SendChat(anveena, SAY_ANVEENA_KALEC, NULL, CHAT_MSG_ADDON, LANG_ADDON, TEXT_RANGE_ZONE);
                    break;
                case EVENT_TEXT_SPEACH43:
                    if (Creature* kalec = ObjectAccessor::GetCreature(*me, instance->GetData64(NPC_KALECGOS_KJ)))
                        kalec->AI()->Talk(SAY_KALECGOS_FATE);
                    break;
                case EVENT_TEXT_SPEACH44:
                    if (Creature* anveena = ObjectAccessor::GetCreature(*me, instance->GetData64(NPC_ANVEENA)))
                        sCreatureTextMgr->SendChat(anveena, SAY_ANVEENA_GOODBYE, NULL, CHAT_MSG_ADDON, LANG_ADDON, TEXT_RANGE_ZONE);
                    break;
                case EVENT_TEXT_SPEACH45:
                    if (Creature* anveena = ObjectAccessor::GetCreature(*me, instance->GetData64(NPC_ANVEENA)))
                    {
                        anveena->RemoveAllAuras();
                        anveena->DespawnOrUnsummon(3500);
                    }
                    break;
                case EVENT_TEXT_SPEACH46:
                    if (Creature* anveena = ObjectAccessor::GetCreature(*me, instance->GetData64(NPC_ANVEENA)))
                    {
                        anveena->CastSpell(anveena, SPELL_SACRIFICE_OF_ANVEENA, true);
                        me->CastSpell(me, SPELL_CUSTOM_08_STATE, true);
                        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PACIFIED);
                        events.DelayEvents(7001);
                        events2.ScheduleEvent(EVENT_RESTORE_MELEE, 7000);
                    }
                    Talk(SAY_KJ_PHASE5);
                    break;
                case EVENT_RESTORE_MELEE:
                    me->RemoveAurasDueToSpell(SPELL_CUSTOM_08_STATE);
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PACIFIED);
                    break;
            }

            if (me->GetReactState() != REACT_AGGRESSIVE)
                return;

            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;
            
            switch (events.ExecuteEvent())
            {
                case EVENT_CHECK_HEALTH85:
                    if (me->HealthBelowPct(85))
                    {
                        phase = PHASE_DARKNESS;
                        events2.CancelEvent(EVENT_GROUP_SPEACH);
                        events2.ScheduleEvent(EVENT_TEXT_SPEACH21, 16000, EVENT_GROUP_SPEACH);
                        events2.ScheduleEvent(EVENT_TEXT_SPEACH22, 22000, EVENT_GROUP_SPEACH);
                        events2.ScheduleEvent(EVENT_TEXT_SPEACH23, 28000, EVENT_GROUP_SPEACH);
                        events2.RescheduleEvent(EVENT_EMPOWER_ORBS1, 35000);
                        
                        events.DelayEvents(2000);
                        events.ScheduleEvent(EVENT_SPELL_SINISTER_REFLECTION, 500);
                        events.ScheduleEvent(EVENT_SPELL_SHADOW_SPIKE, 1200);
                        events.ScheduleEvent(EVENT_SPELL_FLAME_DART, 3000);
                        events.RescheduleEvent(EVENT_SPELL_DARKNESS, 16000); // will be delayed by 29 secs
                        break;
                    }
                    events.ScheduleEvent(EVENT_CHECK_HEALTH85, 0);
                    break;
                
                case EVENT_CHECK_HEALTH55:
                    if (me->HealthBelowPct(55))
                    {
                        phase = PHASE_ARMAGEDDON;
                        events2.CancelEventGroup(EVENT_GROUP_SPEACH);
                        events2.ScheduleEvent(EVENT_TEXT_SPEACH31, 16000, EVENT_GROUP_SPEACH);
                        events2.ScheduleEvent(EVENT_TEXT_SPEACH32, 22000, EVENT_GROUP_SPEACH);
                        events2.ScheduleEvent(EVENT_TEXT_SPEACH33, 28000, EVENT_GROUP_SPEACH);
                        events2.RescheduleEvent(EVENT_EMPOWER_ORBS2, 35000);
                        
                        events.DelayEvents(2000);
                        events.ScheduleEvent(EVENT_SPELL_SINISTER_REFLECTION, 500);
                        events.ScheduleEvent(EVENT_SPELL_SHADOW_SPIKE, 1200);
                        events.RescheduleEvent(EVENT_SPELL_DARKNESS, 15000); // will be delayed by 29 secs
                        events.ScheduleEvent(EVENT_SPELL_ARMAGEDDON, 10000);
                        break;
                    }
                    events.ScheduleEvent(EVENT_CHECK_HEALTH55, 0);
                    break;
                
                case EVENT_CHECK_HEALTH25:
                    if (me->HealthBelowPct(25))
                    {
                        phase = PHASE_SACRIFICE;
                        events2.CancelEventGroup(EVENT_GROUP_SPEACH);
                        events2.ScheduleEvent(EVENT_TEXT_SPEACH41, 8000, EVENT_GROUP_SPEACH);
                        events2.ScheduleEvent(EVENT_TEXT_SPEACH42, 18000, EVENT_GROUP_SPEACH);
                        events2.ScheduleEvent(EVENT_TEXT_SPEACH43, 20200, EVENT_GROUP_SPEACH);
                        events2.ScheduleEvent(EVENT_TEXT_SPEACH44, 25000, EVENT_GROUP_SPEACH);
                        events2.ScheduleEvent(EVENT_TEXT_SPEACH45, 28000, EVENT_GROUP_SPEACH);
                        events2.ScheduleEvent(EVENT_TEXT_SPEACH46, 30000, EVENT_GROUP_SPEACH);
                        events2.RescheduleEvent(EVENT_EMPOWER_ORBS3, 61000);

                        events.CancelEvent(EVENT_SUMMON_ORBS);
                        events.DelayEvents(4000);
                        events.ScheduleEvent(EVENT_SPELL_SINISTER_REFLECTION, 500);
                        events.ScheduleEvent(EVENT_SPELL_SHADOW_SPIKE, 1200);
                        events.RescheduleEvent(EVENT_SPELL_DARKNESS, 15000); // will be delayed by 29 secs
                        events.ScheduleEvent(EVENT_SPELL_ARMAGEDDON, 1500);
                        break;
                    }
                    events.ScheduleEvent(EVENT_CHECK_HEALTH25, 0);
                    break;
                case EVENT_SPELL_SOUL_FLAY:
                    me->CastSpell(me->GetVictim(), SPELL_SOUL_FLAY, false);
                    events.ScheduleEvent(EVENT_SPELL_SOUL_FLAY, urand(4000, 5000));
                    break;
                case EVENT_SPELL_LEGION_LIGHTNING:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 40.0f, true))
                        me->CastSpell(target, SPELL_LEGION_LIGHTNING, false);
                    events.ScheduleEvent(EVENT_SPELL_LEGION_LIGHTNING, phase == PHASE_SACRIFICE ? 15000 : 30000);
                    events.RescheduleEvent(EVENT_SPELL_SOUL_FLAY, 2000);
                    break;
                case EVENT_SPELL_FIRE_BLOOM:
                    me->CastCustomSpell(SPELL_FIRE_BLOOM, SPELLVALUE_MAX_TARGETS, 5, me, TRIGGERED_NONE);
                    me->SetTarget(me->GetVictim()->GetGUID());
                    events.ScheduleEvent(EVENT_SPELL_FIRE_BLOOM, phase == PHASE_SACRIFICE ? 20000 : 40000);
                    events.RescheduleEvent(EVENT_SPELL_SOUL_FLAY, 1500);
                    break;
                case EVENT_SUMMON_ORBS:
                    for (uint8 i = 1; i < phase; ++i)
                    {
                        float x = me->GetPositionX() + 18.0f*cos((i*2.0f-1.0f)*M_PI/3.0f);
                        float y = me->GetPositionY() + 18.0f*sin((i*2.0f-1.0f)*M_PI/3.0f);
                        if (Creature* orb = me->SummonCreature(NPC_SHIELD_ORB, x, y, 40.0f, 0, TEMPSUMMON_CORPSE_DESPAWN))
                        {
                            Movement::PointsArray movementArray;
                            movementArray.push_back(G3D::Vector3(x, y, 40.0f));

                            // generate movement array
                            for (uint8 j = 1; j < 20; ++j)
                            {
                                x = me->GetPositionX() + 18.0f*cos(((i*2.0f-1.0f)*M_PI/3.0f) + (j/20.0f*2*M_PI));
                                y = me->GetPositionY() + 18.0f*sin(((i*2.0f-1.0f)*M_PI/3.0f) + (j/20.0f*2*M_PI));
                                movementArray.push_back(G3D::Vector3(x, y, 40.0f));
                            }
                            
                            Movement::MoveSplineInit init(orb);
                            init.MovebyPath(movementArray);
                            init.SetCyclic();
                            init.Launch();
                        }
                    }
                    events.ScheduleEvent(EVENT_SUMMON_ORBS, 40000);
                    break;
                case EVENT_SPELL_SHADOW_SPIKE:
                    events.DelayEvents(27000);
                    me->CastSpell(me, SPELL_SHADOW_SPIKE, false);
                    break;
                case EVENT_SPELL_SINISTER_REFLECTION:
                    Talk(SAY_KJ_REFLECTION);
                    me->CastCustomSpell(SPELL_SINISTER_REFLECTION, SPELLVALUE_MAX_TARGETS, 1, me, TRIGGERED_NONE);
                    me->CastCustomSpell(SPELL_SINISTER_REFLECTION, SPELLVALUE_MAX_TARGETS, 1, me, TRIGGERED_NONE);
                    me->CastCustomSpell(SPELL_SINISTER_REFLECTION, SPELLVALUE_MAX_TARGETS, 1, me, TRIGGERED_NONE);
                    me->CastCustomSpell(SPELL_SINISTER_REFLECTION, SPELLVALUE_MAX_TARGETS, 1, me, TRIGGERED_NONE);
                    break;
                case EVENT_SPELL_FLAME_DART:
                    me->CastSpell(me, SPELL_FLAME_DART, false);
                    events.ScheduleEvent(EVENT_SPELL_FLAME_DART, 10000);
                    break;
                case EVENT_SPELL_DARKNESS:
                    Talk(EMOTE_KJ_DARKNESS);
                    me->CastSpell(me, SPELL_DARKNESS_OF_A_THOUSAND_SOULS, false);
                    events.ScheduleEvent(EVENT_SPELL_DARKNESS, phase == PHASE_SACRIFICE ? 20000 : 45000);
                    events.DelayEvents(8000);
                    break;
                case EVENT_SPELL_ARMAGEDDON:
                    me->CastSpell(me, SPELL_ARMAGEDDON_PERIODIC, true);
                    events.ScheduleEvent(EVENT_SPELL_ARMAGEDDON, phase == PHASE_SACRIFICE ? 20000 : 40000);
                    break;

            }

            DoMeleeAttackIfReady();
        }

        void EmpowerOrb(bool empowerAll)
        {
            for (uint8 i = 0; i < 4; ++i)
            {
                if (GameObject* orb = ObjectAccessor::GetGameObject(*me, instance->GetData64(DATA_ORB_OF_THE_BLUE_DRAGONFLIGHT_1+i)))
                {
                    if (orb->HasFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE))
                    {
                        orb->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
                        if (Creature* trigger = me->SummonTrigger(orb->GetPositionX(), orb->GetPositionY(), orb->GetPositionZ(), 0, 10*MINUTE*IN_MILLISECONDS))
                        {
                            trigger->CastSpell(trigger, SPELL_RING_OF_BLUE_FLAMES, true, nullptr, nullptr, trigger->GetGUID());
                            if (Creature* controller = ObjectAccessor::GetCreature(*me, instance->GetData64(NPC_KILJAEDEN_CONTROLLER)))
                                controller->AI()->JustSummoned(trigger);
                        }

                        if (!empowerAll)
                            break;
                    }
                }
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return GetInstanceAI<boss_kiljaedenAI>(creature);
    }
};

enum postEvent
{
    SAY_VELEN_01                        = 0,
    SAY_VELEN_02                        = 1,
    SAY_VELEN_03                        = 2,
    SAY_VELEN_04                        = 3,
    SAY_VELEN_05                        = 4,
    SAY_VELEN_06                        = 5,
    SAY_VELEN_07                        = 6,
    SAY_VELEN_08                        = 7,
    SAY_VELEN_09                        = 8,
    SAY_LIADRIN_01                      = 0,
    SAY_LIADRIN_02                      = 1,
    SAY_LIADRIN_03                      = 2,

    NPC_SHATTERED_SUN_RIFTWAKER         = 26289,
    NPC_SHATTRATH_PORTAL_DUMMY          = 26251,
    NPC_INERT_PORTAL                    = 26254,
    NPC_SHATTERED_SUN_SOLDIER           = 26259,
    NPC_LADY_LIADRIN                    = 26247,
    NPC_PROPHET_VELEN                   = 26246,
    NPC_THE_CORE_OF_ENTROPIUS           = 26262,

    SPELL_TELEPORT_AND_TRANSFORM        = 46473,
    SPELL_OPEN_PORTAL_FROM_SHATTRATH    = 46801,
    SPELL_TELEPORT_VISUAL               = 35517,
    SPELL_BOSS_ARCANE_PORTAL_STATE      = 42047,
    SPELL_CALL_ENTROPIUS                = 46818,
    SPELL_BLAZE_TO_LIGHT                = 46821,
    SPELL_SUNWELL_IGNITION              = 46822,

    EVENT_SCENE_01                      = 1,
    EVENT_SCENE_02,
    EVENT_SCENE_03,
    EVENT_SCENE_04,
    EVENT_SCENE_05,
    EVENT_SCENE_06,
    EVENT_SCENE_07,
    EVENT_SCENE_08,
    EVENT_SCENE_09,
    EVENT_SCENE_10,
    EVENT_SCENE_11,
    EVENT_SCENE_12,
    EVENT_SCENE_13,
    EVENT_SCENE_14,
    EVENT_SCENE_15,
    EVENT_SCENE_16,
    EVENT_SCENE_17,
    EVENT_SCENE_18,
    EVENT_SCENE_19,
    EVENT_SCENE_20,
    EVENT_SCENE_21,
    EVENT_SCENE_22,
    EVENT_SCENE_23,
    EVENT_SCENE_24,
    EVENT_SCENE_25,
    EVENT_SCENE_26,
    EVENT_SCENE_27
};

class MoveDelayed : public BasicEvent
{
    public:
        MoveDelayed(Creature* owner, float x, float y, float z, float o) : _owner(owner), _x(x), _y(y), _z(z), _o(o)
        {
        }

        bool Execute(uint64 /*execTime*/, uint32 /*diff*/)
        {
            Movement::MoveSplineInit init(_owner);
            init.MoveTo(_x, _y, _z, false, true);
            init.SetFacing(_o);
            init.Launch();
            return true;
        }

    private:
        Creature* _owner;
        float _x, _y, _z, _o;
};

class FixOrientation : public BasicEvent
{
    public:
        FixOrientation(Creature* owner) : _owner(owner)
        {
        }

        bool Execute(uint64 /*execTime*/, uint32 /*diff*/)
        {
            std::list<Creature*> cList;
            _owner->GetCreaturesWithEntryInRange(cList, 20.0f, NPC_SHATTERED_SUN_SOLDIER);
            for (std::list<Creature*>::const_iterator itr = cList.begin(); itr != cList.end(); ++itr)
                (*itr)->SetFacingTo(_owner->GetOrientation());
            return true;
        }

    private:
        Creature* _owner;
};

class npc_kalecgos_kj : public CreatureScript
{
public:
    npc_kalecgos_kj() : CreatureScript("npc_kalecgos_kj") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return GetInstanceAI<npc_kalecgos_kjAI>(creature);
    }

    struct npc_kalecgos_kjAI : public NullCreatureAI
    {
        npc_kalecgos_kjAI(Creature* creature) : NullCreatureAI(creature), summons(me)
        {
            instance = creature->GetInstanceScript();
        }

        EventMap events;
        InstanceScript* instance;
        SummonList summons;

        void Reset()
        {
            events.Reset();
            summons.DespawnAll();
        }

        void DoAction(int32 param)
        {
            if (param == ACTION_START_POST_EVENT)
            {
                me->SetDisableGravity(false);
                me->SetCanFly(false);
                me->CastSpell(me, SPELL_TELEPORT_AND_TRANSFORM, true);
                events.ScheduleEvent(EVENT_SCENE_01, 35000);
            }
        }

        void JustSummoned(Creature* summon)
        {
            summons.Summon(summon);
            if (summon->GetEntry() == NPC_SHATTERED_SUN_RIFTWAKER)
            {
                summon->CastSpell(summon, SPELL_TELEPORT_VISUAL, true);
                Movement::MoveSplineInit init(summon);
                if (summons.size() == 1)
                {
                    init.MoveTo(1727.08f, 656.82f, 28.37f, false, true);
                    init.SetFacing(5.14f);
                }
                else
                {
                    init.MoveTo(1738.84f, 627.32f, 28.26f, false, true);
                    init.SetFacing(2.0f);
                }
                init.Launch();
            }
            else if (summon->GetEntry() == NPC_SHATTRATH_PORTAL_DUMMY)
            {
                if (Creature* riftwaker = summon->FindNearestCreature(NPC_SHATTERED_SUN_RIFTWAKER, 10.0f))
                    riftwaker->CastSpell(summon, SPELL_OPEN_PORTAL_FROM_SHATTRATH, false);
                summon->SetWalk(true);
                summon->GetMotionMaster()->MovePoint(0, summon->GetPositionX(), summon->GetPositionY(), summon->GetPositionZ()+30.0f, false, true);
            }
            else if (summon->GetEntry() == NPC_INERT_PORTAL)
                summon->CastSpell(summon, SPELL_BOSS_ARCANE_PORTAL_STATE, true);
            else if (summon->GetEntry() == NPC_SHATTERED_SUN_SOLDIER)
                summon->CastSpell(summon, SPELL_TELEPORT_VISUAL, true);
            else if (summon->GetEntry() == NPC_LADY_LIADRIN)
            {
                summon->CastSpell(summon, SPELL_TELEPORT_VISUAL, true);
                summon->SetWalk(true);
            }
            else if (summon->GetEntry() == NPC_PROPHET_VELEN)
            {
                summon->CastSpell(summon, SPELL_TELEPORT_VISUAL, true);
                summon->SetWalk(true);
                summon->GetMotionMaster()->MovePoint(0, 1710.15f, 639.23f, 27.311f, false, true);
            }
            else if (summon->GetEntry() == NPC_THE_CORE_OF_ENTROPIUS)
                summon->GetMotionMaster()->MovePoint(0, summon->GetPositionX(), summon->GetPositionY(), 30.0f);
        }

        void UpdateAI(uint32 diff)
        {
            events.Update(diff);
            switch (uint32 eventId = events.ExecuteEvent())
            {
                case EVENT_SCENE_01:
                    Talk(SAY_KALECGOS_GOODBYE);
                    events.ScheduleEvent(eventId+1, 15000);
                    break;
                case EVENT_SCENE_02:
                    me->SummonCreature(NPC_SHATTERED_SUN_RIFTWAKER, 1688.42f, 641.82f, 27.60f, 0.67f);
                    me->SummonCreature(NPC_SHATTERED_SUN_RIFTWAKER, 1712.58f, 616.29f, 27.78f, 0.76f);
                    events.ScheduleEvent(eventId+1, 6000);
                    break;
                case EVENT_SCENE_03:
                    me->SummonCreature(NPC_SHATTRATH_PORTAL_DUMMY, 1727.08f+cos(5.14f), 656.82f+sin(5.14f), 28.37f+2.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 10000);
                    me->SummonCreature(NPC_SHATTRATH_PORTAL_DUMMY, 1738.84f+cos(2.0f), 627.32f+sin(2.0f), 28.26f+2.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 10000);
                    events.ScheduleEvent(eventId+1, 11000);
                    break;
                case EVENT_SCENE_04:
                    me->SummonCreature(NPC_INERT_PORTAL, 1734.96f, 642.43f, 28.06f, 3.49f);
                    events.ScheduleEvent(eventId+1, 4000);
                    break;
                case EVENT_SCENE_05:
                    if (Creature* first = me->SummonCreature(NPC_SHATTERED_SUN_SOLDIER, 1729.48f, 640.49f, 28.06f, 3.49f))
                    {
                        first->m_Events.AddEvent(new MoveDelayed(first, 1718.70f, 607.78f, 28.06f, 2.323f), first->m_Events.CalculateTime(5000));
                        first->m_Events.AddEvent(new FixOrientation(first), first->m_Events.CalculateTime(12000));
                        for (uint8 i = 0; i < 9; ++i)
                            if (Creature* follower = me->SummonCreature(NPC_SHATTERED_SUN_SOLDIER, 1729.48f+5*cos(i*2.0f*M_PI/9), 640.49f+5*sin(i*2.0f*M_PI/9), 28.06f, 3.49f))
                                follower->GetMotionMaster()->MoveFollow(first, 3.0f, follower->GetAngle(first));
                    }
                    events.ScheduleEvent(eventId+1, 10000);
                    break;
                case EVENT_SCENE_06:
                    if (Creature* first = me->SummonCreature(NPC_SHATTERED_SUN_SOLDIER, 1729.48f, 640.49f, 28.06f, 3.49f))
                    {
                        first->m_Events.AddEvent(new MoveDelayed(first, 1678.69f, 649.27f, 28.06f, 5.46f), first->m_Events.CalculateTime(5000));
                        first->m_Events.AddEvent(new FixOrientation(first), first->m_Events.CalculateTime(14500));
                        for (uint8 i = 0; i < 9; ++i)
                            if (Creature* follower = me->SummonCreature(NPC_SHATTERED_SUN_SOLDIER, 1729.48f+5*cos(i*2.0f*M_PI/9), 640.49f+5*sin(i*2.0f*M_PI/9), 28.06f, 3.49f))
                                follower->GetMotionMaster()->MoveFollow(first, 3.0f, follower->GetAngle(first));
                    }
                    events.ScheduleEvent(eventId+1, 12000);
                    break;
                case EVENT_SCENE_07:
                    me->SummonCreature(NPC_LADY_LIADRIN, 1719.87f, 644.265f, 28.06f, 3.83f);
                    me->SummonCreature(NPC_PROPHET_VELEN, 1717.97f, 646.44f, 28.06f, 3.94f);
                    events.ScheduleEvent(eventId+1, 7000);
                    break;
                case EVENT_SCENE_08:
                    if (Creature* velen = summons.GetCreatureWithEntry(NPC_PROPHET_VELEN))
                        velen->AI()->Talk(SAY_VELEN_01);
                    events.ScheduleEvent(eventId+1, 25000);
                    break;
                case EVENT_SCENE_09:
                    if (Creature* velen = summons.GetCreatureWithEntry(NPC_PROPHET_VELEN))
                        velen->AI()->Talk(SAY_VELEN_02);
                    events.ScheduleEvent(eventId+1, 14500);
                    break;
                case EVENT_SCENE_10:
                    if (Creature* velen = summons.GetCreatureWithEntry(NPC_PROPHET_VELEN))
                        velen->AI()->Talk(SAY_VELEN_03);
                    events.ScheduleEvent(eventId+1, 12500);
                    break;
                case EVENT_SCENE_11:
                    me->SummonCreature(NPC_THE_CORE_OF_ENTROPIUS, 1698.86f, 628.73f, 92.83f, 0.0f);
                    if (Creature* velen = summons.GetCreatureWithEntry(NPC_PROPHET_VELEN))
                        velen->CastSpell(velen, SPELL_CALL_ENTROPIUS, false);
                    events.ScheduleEvent(eventId+1, 8000);
                    break;
                case EVENT_SCENE_12:
                    if (Creature* velen = summons.GetCreatureWithEntry(NPC_PROPHET_VELEN))
                    {
                        velen->InterruptNonMeleeSpells(false);
                        velen->AI()->Talk(SAY_VELEN_04);
                    }
                    events.ScheduleEvent(eventId+1, 20000);
                    break;
                case EVENT_SCENE_13:
                    if (Creature* liadrin = summons.GetCreatureWithEntry(NPC_LADY_LIADRIN))
                        liadrin->GetMotionMaster()->MovePoint(0, 1711.28f, 637.29f, 27.29f);
                    events.ScheduleEvent(eventId+1, 6000);
                    break;
                case EVENT_SCENE_14:
                    if (Creature* liadrin = summons.GetCreatureWithEntry(NPC_LADY_LIADRIN))
                        liadrin->AI()->Talk(SAY_LIADRIN_01);
                    events.ScheduleEvent(eventId+1, 10000);
                    break;
                case EVENT_SCENE_15:
                    if (Creature* velen = summons.GetCreatureWithEntry(NPC_PROPHET_VELEN))
                        velen->AI()->Talk(SAY_VELEN_05);
                    events.ScheduleEvent(eventId+1, 14000);
                    break;
                case EVENT_SCENE_16:
                    if (Creature* liadrin = summons.GetCreatureWithEntry(NPC_LADY_LIADRIN))
                        liadrin->AI()->Talk(SAY_LIADRIN_02);
                    events.ScheduleEvent(eventId+1, 2000);
                    break;
                case EVENT_SCENE_17:
                    if (Creature* velen = summons.GetCreatureWithEntry(NPC_PROPHET_VELEN))
                        velen->AI()->Talk(SAY_VELEN_06);
                    events.ScheduleEvent(eventId+1, 3000);
                    break;
                case EVENT_SCENE_18:
                    if (Creature* core = summons.GetCreatureWithEntry(NPC_THE_CORE_OF_ENTROPIUS))
                    {
                        core->RemoveAllAuras();
                        core->CastSpell(core, SPELL_BLAZE_TO_LIGHT, true);
                    }
                    events.ScheduleEvent(eventId+1, 8000);
                    break;
                case EVENT_SCENE_19:
                    if (Creature* core = summons.GetCreatureWithEntry(NPC_THE_CORE_OF_ENTROPIUS))
                    {
                        core->SetObjectScale(0.75f);
                        core->GetMotionMaster()->MovePoint(0, core->GetPositionX(), core->GetPositionY(), 28.0f);
                    }
                    events.ScheduleEvent(eventId+1, 2000);
                    break;
                case EVENT_SCENE_20:
                    if (Creature* core = summons.GetCreatureWithEntry(NPC_THE_CORE_OF_ENTROPIUS))
                        core->CastSpell(core, SPELL_SUNWELL_IGNITION, true);
                    events.ScheduleEvent(eventId+1, 3000);
                    break;
                case EVENT_SCENE_21:
                    if (Creature* velen = summons.GetCreatureWithEntry(NPC_PROPHET_VELEN))
                        velen->AI()->Talk(SAY_VELEN_07);
                    events.ScheduleEvent(eventId+1, 15000);
                    break;
                case EVENT_SCENE_22:
                    if (Creature* liadrin = summons.GetCreatureWithEntry(NPC_LADY_LIADRIN))
                        liadrin->AI()->Talk(SAY_LIADRIN_03);
                    events.ScheduleEvent(eventId+1, 20000);
                    break;
                case EVENT_SCENE_23:
                    if (Creature* velen = summons.GetCreatureWithEntry(NPC_PROPHET_VELEN))
                        velen->AI()->Talk(SAY_VELEN_08);
                    if (Creature* liadrin = summons.GetCreatureWithEntry(NPC_LADY_LIADRIN))
                        liadrin->SetStandState(UNIT_STAND_STATE_KNEEL);
                    events.ScheduleEvent(eventId+1, 8000);
                    break;
                case EVENT_SCENE_24:
                    if (Creature* velen = summons.GetCreatureWithEntry(NPC_PROPHET_VELEN))
                        velen->AI()->Talk(SAY_VELEN_09);
                    events.ScheduleEvent(eventId+1, 5000);
                    break;
                case EVENT_SCENE_25:
                    if (Creature* velen = summons.GetCreatureWithEntry(NPC_PROPHET_VELEN))
                    {
                        velen->GetMotionMaster()->MovePoint(0, 1739.38f, 643.79f, 28.06f);
                        velen->DespawnOrUnsummon(5000);
                    }
                    events.ScheduleEvent(eventId+1, 3000);
                    break;
                case EVENT_SCENE_26:
                    for (SummonList::const_iterator itr = summons.begin(); itr != summons.end(); ++itr)
                        if (Creature* summon = ObjectAccessor::GetCreature(*me, *itr))
                            if (summon->GetEntry() == NPC_SHATTERED_SUN_SOLDIER)
                            {
                                summon->GetMotionMaster()->MovePoint(0, 1739.38f, 643.79f, 28.06f);
                                summon->DespawnOrUnsummon(summon->GetExactDist2d(1734.96f, 642.43f)*100);
                            }
                    events.ScheduleEvent(eventId+1, 7000);
                    break;
                case EVENT_SCENE_27:
                    me->setActive(false);
                    summons.DespawnEntry(NPC_INERT_PORTAL);
                    summons.DespawnEntry(NPC_SHATTERED_SUN_RIFTWAKER);
                    break;
            }
        }
    };
};

class spell_kiljaeden_shadow_spike : public SpellScriptLoader
{
    public:
        spell_kiljaeden_shadow_spike() : SpellScriptLoader("spell_kiljaeden_shadow_spike") { }

        class spell_kiljaeden_shadow_spike_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_kiljaeden_shadow_spike_AuraScript);

            void HandlePeriodic(AuraEffect const* aurEff)
            {
                PreventDefaultAction();
                if (Unit* target = GetUnitOwner()->GetAI()->SelectTarget(SELECT_TARGET_RANDOM, 0, 60.0f, true))
                    GetUnitOwner()->CastSpell(target, GetSpellInfo()->Effects[aurEff->GetEffIndex()].TriggerSpell, true);
            }

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_kiljaeden_shadow_spike_AuraScript::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_kiljaeden_shadow_spike_AuraScript();
        }
};

class spell_kiljaeden_sinister_reflection : public SpellScriptLoader
{
    public:
        spell_kiljaeden_sinister_reflection() : SpellScriptLoader("spell_kiljaeden_sinister_reflection") { }

        class spell_kiljaeden_sinister_reflection_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_kiljaeden_sinister_reflection_SpellScript);

            void FilterTargets(std::list<WorldObject*>& targets)
            {
                targets.remove_if(acore::UnitAuraCheck(true, SPELL_VENGEANCE_OF_THE_BLUE_FLIGHT));
            }

            void HandleScriptEffect(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                if (Unit* target = GetHitUnit())
                {
                    target->CastSpell(target, SPELL_SINISTER_REFLECTION_SUMMON, true);
                    //target->CastSpell(target, SPELL_SINISTER_REFLECTION_CLONE, true);
                }
            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_kiljaeden_sinister_reflection_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
                OnEffectHitTarget += SpellEffectFn(spell_kiljaeden_sinister_reflection_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_kiljaeden_sinister_reflection_SpellScript();
        }
};

class spell_kiljaeden_sinister_reflection_clone : public SpellScriptLoader
{
    public:
        spell_kiljaeden_sinister_reflection_clone() : SpellScriptLoader("spell_kiljaeden_sinister_reflection_clone") { }

        class spell_kiljaeden_sinister_reflection_clone_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_kiljaeden_sinister_reflection_clone_SpellScript);

            void FilterTargets(std::list<WorldObject*>& targets)
            {
                targets.sort(acore::ObjectDistanceOrderPred(GetCaster()));
                WorldObject* target = targets.front();
                
                targets.clear();
                if (target && target->GetTypeId() == TYPEID_UNIT)
                {
                    target->ToCreature()->AI()->SetData(1, GetCaster()->getClass());
                    targets.push_back(target);
                }               
            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_kiljaeden_sinister_reflection_clone_SpellScript::FilterTargets, EFFECT_ALL, TARGET_UNIT_SRC_AREA_ENEMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_kiljaeden_sinister_reflection_clone_SpellScript();
        }
};

class spell_kiljaeden_flame_dart : public SpellScriptLoader
{
    public:
        spell_kiljaeden_flame_dart() : SpellScriptLoader("spell_kiljaeden_flame_dart") { }

        class spell_kiljaeden_flame_dart_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_kiljaeden_flame_dart_SpellScript);

            void HandleSchoolDamage(SpellEffIndex  /*effIndex*/)
            {
                if (Unit* target = GetHitUnit())
                    target->CastSpell(target, SPELL_FLAME_DART_EXPLOSION, true);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_kiljaeden_flame_dart_SpellScript::HandleSchoolDamage, EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_kiljaeden_flame_dart_SpellScript();
        }
};

class spell_kiljaeden_darkness : public SpellScriptLoader
{
    public:
        spell_kiljaeden_darkness() : SpellScriptLoader("spell_kiljaeden_darkness") { }

        class spell_kiljaeden_darkness_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_kiljaeden_darkness_AuraScript);

            void HandleRemove(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (GetUnitOwner()->GetTypeId() == TYPEID_UNIT)
                    GetUnitOwner()->ToCreature()->AI()->DoAction(ACTION_NO_KILL_TALK);

                GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_DARKNESS_OF_A_THOUSAND_SOULS_DAMAGE, true);
            }

            void Register()
            {
                OnEffectRemove += AuraEffectRemoveFn(spell_kiljaeden_darkness_AuraScript::HandleRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_kiljaeden_darkness_AuraScript();
        }
};

class spell_kiljaeden_power_of_the_blue_flight : public SpellScriptLoader
{
    public:
        spell_kiljaeden_power_of_the_blue_flight() : SpellScriptLoader("spell_kiljaeden_power_of_the_blue_flight") { }

        class spell_kiljaeden_power_of_the_blue_flight_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_kiljaeden_power_of_the_blue_flight_SpellScript);

            void HandleScriptEffect(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                if (Player* player = GetHitPlayer())
                {
                    player->CastSpell(player, SPELL_SUMMON_BLUE_DRAKE, true);
                    player->CastSpell(player, SPELL_VENGEANCE_OF_THE_BLUE_FLIGHT, true);
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_kiljaeden_power_of_the_blue_flight_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_kiljaeden_power_of_the_blue_flight_SpellScript();
        }
};

class spell_kiljaeden_vengeance_of_the_blue_flight : public SpellScriptLoader
{
    public:
        spell_kiljaeden_vengeance_of_the_blue_flight() : SpellScriptLoader("spell_kiljaeden_vengeance_of_the_blue_flight") { }

        class spell_kiljaeden_vengeance_of_the_blue_flight_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_kiljaeden_vengeance_of_the_blue_flight_AuraScript);

            void HandleApply(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_POSSESS_DRAKE_IMMUNITY, true);
            }

            void HandleRemove(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                GetUnitOwner()->RemoveAurasDueToSpell(SPELL_POSSESS_DRAKE_IMMUNITY);
            }

            void Register()
            {
                OnEffectApply += AuraEffectApplyFn(spell_kiljaeden_vengeance_of_the_blue_flight_AuraScript::HandleApply, EFFECT_0, SPELL_AURA_MOD_POSSESS, AURA_EFFECT_HANDLE_REAL);
                OnEffectApply += AuraEffectApplyFn(spell_kiljaeden_vengeance_of_the_blue_flight_AuraScript::HandleApply, EFFECT_2, SPELL_AURA_MOD_PACIFY_SILENCE, AURA_EFFECT_HANDLE_REAL);
                OnEffectRemove += AuraEffectRemoveFn(spell_kiljaeden_vengeance_of_the_blue_flight_AuraScript::HandleRemove, EFFECT_0, SPELL_AURA_MOD_POSSESS, AURA_EFFECT_HANDLE_REAL);
                OnEffectRemove += AuraEffectRemoveFn(spell_kiljaeden_vengeance_of_the_blue_flight_AuraScript::HandleRemove, EFFECT_2, SPELL_AURA_MOD_PACIFY_SILENCE, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_kiljaeden_vengeance_of_the_blue_flight_AuraScript();
        }
};

class spell_kiljaeden_armageddon_periodic : public SpellScriptLoader
{
    public:
        spell_kiljaeden_armageddon_periodic() : SpellScriptLoader("spell_kiljaeden_armageddon_periodic") { }

        class spell_kiljaeden_armageddon_periodic_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_kiljaeden_armageddon_periodic_AuraScript);

            void HandlePeriodic(AuraEffect const* aurEff)
            {
                PreventDefaultAction();
                if (Unit* target = GetUnitOwner()->GetAI()->SelectTarget(SELECT_TARGET_RANDOM, 0, 60.0f, true))
                    GetUnitOwner()->CastSpell(target, GetSpellInfo()->Effects[aurEff->GetEffIndex()].TriggerSpell, true);
            }

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_kiljaeden_armageddon_periodic_AuraScript::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_kiljaeden_armageddon_periodic_AuraScript();
        }
};

class spell_kiljaeden_armageddon_missile : public SpellScriptLoader
{
    public:
        spell_kiljaeden_armageddon_missile() : SpellScriptLoader("spell_kiljaeden_armageddon_missile") { }

        class spell_kiljaeden_armageddon_missile_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_kiljaeden_armageddon_missile_SpellScript);

            void SetDest(SpellDestination& dest)
            {
                Position const offset = { 0.0f, 0.0f, -20.0f, 0.0f };
                dest.RelocateOffset(offset);
            }

            void Register()
            {
                OnDestinationTargetSelect += SpellDestinationTargetSelectFn(spell_kiljaeden_armageddon_missile_SpellScript::SetDest, EFFECT_0, TARGET_DEST_CASTER);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_kiljaeden_armageddon_missile_SpellScript();
        }
};

class spell_kiljaeden_dragon_breath : public SpellScriptLoader
{
    public:
        spell_kiljaeden_dragon_breath() : SpellScriptLoader("spell_kiljaeden_dragon_breath") { }

        class spell_kiljaeden_dragon_breath_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_kiljaeden_dragon_breath_SpellScript);

            void FilterTargets(std::list<WorldObject*>& targets)
            {
                targets.remove_if(acore::UnitAuraCheck(true, SPELL_VENGEANCE_OF_THE_BLUE_FLIGHT));
            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_kiljaeden_dragon_breath_SpellScript::FilterTargets, EFFECT_ALL, TARGET_UNIT_CONE_ALLY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_kiljaeden_dragon_breath_SpellScript();
        }
};

void AddSC_boss_kiljaeden()
{
    new npc_kiljaeden_controller();
    new boss_kiljaeden();
    new npc_kalecgos_kj();
    new spell_kiljaeden_shadow_spike();
    new spell_kiljaeden_sinister_reflection();
    new spell_kiljaeden_sinister_reflection_clone();
    new spell_kiljaeden_flame_dart();
    new spell_kiljaeden_darkness();
    new spell_kiljaeden_power_of_the_blue_flight();
    new spell_kiljaeden_vengeance_of_the_blue_flight();
    new spell_kiljaeden_armageddon_periodic();
    new spell_kiljaeden_armageddon_missile();
    new spell_kiljaeden_dragon_breath();
}
