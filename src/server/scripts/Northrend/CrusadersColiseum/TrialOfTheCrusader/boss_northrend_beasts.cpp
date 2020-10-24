/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "trial_of_the_crusader.h"
#include "Vehicle.h"
#include "Player.h"

/***********
** GORMOK
***********/

enum GormokSpells
{
    SPELL_IMPALE                        = 66331,
    SPELL_STAGGERING_STOMP              = 67648,
    SPELL_RISING_ANGER                  = 66636,
    SPELL_CHANGE_VEHICLE                = 66342, // custom spell
    //Snobold
    SPELL_SNOBOLLED                     = 66406,
    SPELL_BATTER                        = 66408,
    SPELL_FIRE_BOMB                     = 66313,
    SPELL_FIRE_BOMB_AURA                = 66318,
    SPELL_HEAD_CRACK                    = 66407,
};

enum GormokEvents
{
    EVENT_SPELL_IMPALE = 1,
    EVENT_SPELL_STAGGERING_STOMP,
    EVENT_PICK_SNOBOLD_TARGET,
    EVENT_RELEASE_SNOBOLD,

    EVENT_SPELL_SNOBOLLED,
    EVENT_SPELL_BATTER,
    EVENT_SPELL_FIRE_BOMB,
    EVENT_SPELL_HEAD_CRACK,
};

enum GormokNPCs
{
    NPC_SNOBOLD_VASSAL                  = 34800,
    NPC_FIRE_BOMB                       = 34854,
};

enum Yells
{
    // Gormok
    EMOTE_SNOBOLLED         = 0,

    // Acidmaw & Dreadscale
    EMOTE_ENRAGE            = 0,
    EMOTE_SUBMERGE          = 1,
    EMOTE_EMERGE            = 2,

    // Icehowl
    EMOTE_TRAMPLE_STARE     = 0,
    EMOTE_TRAMPLE_CRASH     = 1,
    EMOTE_TRAMPLE_FAIL      = 2,
};

class npc_snobold_vassal : public CreatureScript
{
public:
    npc_snobold_vassal() : CreatureScript("npc_snobold_vassal") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_snobold_vassalAI(pCreature);
    }

    struct npc_snobold_vassalAI : public ScriptedAI
    {
        npc_snobold_vassalAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            pInstance = pCreature->GetInstanceScript();
            TargetGUID = 0;
            me->SetReactState(REACT_PASSIVE);
        }

        InstanceScript* pInstance;
        EventMap events;
        uint64 TargetGUID;

        void Reset()
        {
            events.Reset();
            events.ScheduleEvent(EVENT_SPELL_FIRE_BOMB, urand(10000, 30000));
        }

        void EnterCombat(Unit*  /*who*/)
        {
            events.Reset();
            events.ScheduleEvent(EVENT_SPELL_SNOBOLLED, 1500);
            events.ScheduleEvent(EVENT_SPELL_BATTER, 5000);
            events.ScheduleEvent(EVENT_SPELL_HEAD_CRACK, 25000);
        }

        void AttackStart(Unit* who)
        {
            if( who->GetGUID() != TargetGUID )
                return;
            ScriptedAI::AttackStart(who);
        }

        void MoveInLineOfSight(Unit* /*who*/) {}

        void UpdateAI(uint32 diff)
        {
            if( !TargetGUID && !me->GetVehicle() )
                return;

            Unit* t = ObjectAccessor::GetUnit(*me, TargetGUID);
            if( !t && !(t = me->GetVehicleBase()) )
                return;

            if( t->isDead() )
            {
                t->RemoveAura(SPELL_CHANGE_VEHICLE);
                me->RemoveAllAuras();
                me->DeleteThreatList();
                me->CombatStop(true);
                me->SetHealth(me->GetMaxHealth());
                if( pInstance )
                    if( Creature* gormok = ObjectAccessor::GetCreature(*me, pInstance->GetData64(TYPE_GORMOK)) )
                        if( gormok->IsAlive() )
                            if( Vehicle* vk = gormok->GetVehicleKit() )
                                for( uint8 i = 0; i < 4; ++i )
                                    if( !vk->GetPassenger(i) )
                                    {
                                        me->EnterVehicleUnattackable(gormok, i);
                                        Reset();
                                        break;
                                    }
                TargetGUID = 0;
                return;
            }

            events.Update(diff);

            if( me->HasUnitState(UNIT_STATE_CASTING) )
                return;

            switch( events.ExecuteEvent() )
            {
                case 0:
                    break;
                case EVENT_SPELL_SNOBOLLED:
                    if( t->GetTypeId() == TYPEID_PLAYER )
                        me->CastSpell((Unit*)NULL, SPELL_SNOBOLLED, true);
                    
                    break;
                case EVENT_SPELL_BATTER:
                    if( t->GetTypeId() == TYPEID_PLAYER )
                        me->CastSpell(t, SPELL_BATTER);
                    events.RepeatEvent(urand(6000, 8000));
                    break;
                case EVENT_SPELL_FIRE_BOMB:
                    {
                        if( t->GetTypeId() != TYPEID_PLAYER && pInstance )
                        {
                            std::vector<uint64> validPlayers;
                            Map::PlayerList const& pl = me->GetMap()->GetPlayers();
                            Creature* gormok = ObjectAccessor::GetCreature(*me, pInstance->GetData64(TYPE_GORMOK));

                            for( Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr )
                            {
                                if( Player* p = itr->GetSource() )
                                    if( p->IsAlive() && p->GetGUID() != TargetGUID && (!gormok || !p->IsWithinMeleeRange(gormok)) )
                                        validPlayers.push_back(p->GetGUID());
                            }

                            if( !validPlayers.empty() )
                                if( Player* p = ObjectAccessor::GetPlayer(*me, validPlayers.at(urand(0, validPlayers.size() - 1))) )
                                    if( Creature* trigger = me->SummonCreature(NPC_FIRE_BOMB, *p, TEMPSUMMON_TIMED_DESPAWN, 60000) )
                                    {
                                        me->CastSpell(trigger, SPELL_FIRE_BOMB_AURA, true); // periodic damage aura, speed 14.0f
                                        me->CastSpell(trigger, SPELL_FIRE_BOMB); // visual + initial damage 4k
                                    }
                        }

                        events.RepeatEvent(urand(20000, 30000));
                    }
                    break;
                case EVENT_SPELL_HEAD_CRACK:
                    if( t->GetTypeId() == TYPEID_PLAYER )
                        me->CastSpell(t, SPELL_HEAD_CRACK);
                    events.RepeatEvent(urand(30000, 35000));
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*pKiller*/)
        {
            if( Unit* t = ObjectAccessor::GetUnit(*me, TargetGUID))
            {
                t->RemoveAura(SPELL_CHANGE_VEHICLE);
                if( t->IsAlive() )
                    t->RemoveAurasDueToSpell(SPELL_SNOBOLLED);
            }
        }

        void DoAction(int32 param)
        {
            if( param == 1 && !TargetGUID )
                me->DespawnOrUnsummon();
        }
    };
};

class boss_gormok : public CreatureScript
{
public:
    boss_gormok() : CreatureScript("boss_gormok") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_gormokAI(pCreature);
    }

    struct boss_gormokAI : public ScriptedAI
    {
        boss_gormokAI(Creature* pCreature) : ScriptedAI(pCreature), summons(pCreature)
        {
            pInstance = pCreature->GetInstanceScript();
            me->AddUnitMovementFlag(MOVEMENTFLAG_WALKING);
            me->SetReactState(REACT_PASSIVE);
        }

        InstanceScript* pInstance;
        EventMap events;
        SummonList summons;
        uint64 PlayerGUID;

        void Reset()
        {
            events.Reset();
            summons.DespawnAll();
            PlayerGUID = 0;
        }

        void EnterCombat(Unit* /*who*/)
        {
            me->setActive(true);
            events.Reset();
            events.RescheduleEvent(EVENT_SPELL_IMPALE, urand(9000, 10000));
            events.RescheduleEvent(EVENT_SPELL_STAGGERING_STOMP, 15000);
            events.RescheduleEvent(EVENT_PICK_SNOBOLD_TARGET, urand(16000, 24000));

            // refresh snobold position
            if( Vehicle* vk = me->GetVehicleKit() )
                for( uint8 i = 0; i < 4; ++i )
                    if( Unit* snobold = vk->GetPassenger(i) )
                        snobold->SendMovementFlagUpdate();
        }

        void JustReachedHome()
        {
            me->setActive(false);
        }

        void MoveInLineOfSight(Unit* /*who*/) {}

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
                case EVENT_SPELL_IMPALE:
                    if( !me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISARMED) )
                    {
                        if( Unit* victim = me->GetVictim() )
                            me->CastSpell(victim, SPELL_IMPALE, false);
                        events.RepeatEvent(urand(9000, 10000));
                    }
                    else
                        events.RepeatEvent(2500);
                    break;
                case EVENT_SPELL_STAGGERING_STOMP:
                    me->CastSpell((Unit*)NULL, SPELL_STAGGERING_STOMP, false);
                    events.RepeatEvent(urand(20000, 25000));
                    break;
                case EVENT_PICK_SNOBOLD_TARGET:
                    if( Vehicle* vk = me->GetVehicleKit() )
                        for( uint8 i = 0; i < 4; ++i )
                            if( Unit* snobold = vk->GetPassenger(i) )
                            {
                                std::vector<uint64> validPlayers;
                                Map::PlayerList const& pl = me->GetMap()->GetPlayers();
                                for( Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr )
                                {
                                    if( Player* p = itr->GetSource() )
                                        if( p->IsAlive() && !p->GetVehicleKit() && !p->IsMounted() && !p->GetVehicle() && !p->IsGameMaster() )
                                            validPlayers.push_back(p->GetGUID());
                                }

                                if( !validPlayers.empty() )
                                    if( Player* p = ObjectAccessor::GetPlayer(*me, validPlayers.at(urand(0, validPlayers.size() - 1))) )
                                    {
                                        snobold->ChangeSeat(4); // switch to hand
                                        me->setAttackTimer(BASE_ATTACK, 3000);
                                        PlayerGUID = p->GetGUID();
                                        events.RescheduleEvent(EVENT_RELEASE_SNOBOLD, 2500);
                                    }

                                break;
                            }
                    events.RepeatEvent(urand(16000, 24000));
                    break;
                case EVENT_RELEASE_SNOBOLD:
                    {
                        me->CastSpell(me, SPELL_RISING_ANGER, true);
                        Player* p = ObjectAccessor::GetPlayer(*me, PlayerGUID);
                        if( p && p->IsAlive() && !p->GetVehicleKit() && !p->IsMounted() && !p->GetVehicle() )
                        {
                            if( Vehicle* vk = me->GetVehicleKit() )
                                if( Unit* snobold = vk->GetPassenger(4) )
                                {
                                    if( snobold->GetTypeId() == TYPEID_UNIT )
                                    {
                                        CAST_AI(npc_snobold_vassal::npc_snobold_vassalAI, snobold->ToCreature()->AI())->TargetGUID = PlayerGUID;
                                        snobold->ToCreature()->AI()->AttackStart(p);
                                    }
                                    //Talk(EMOTE_SNOBOLLED);
                                    p->CastSpell(p, SPELL_CHANGE_VEHICLE, true);
                                    snobold->EnterVehicle(p, 0);
                                    //snobold->ClearUnitState(UNIT_STATE_ONVEHICLE);
                                }
                        }
                        else if( Vehicle* vk = me->GetVehicleKit() )
                        {
                            events.RescheduleEvent(EVENT_PICK_SNOBOLD_TARGET, 5000); // player not found (died? left instance?), pick new one faster!
                            if( Unit* snobold = vk->GetPassenger(4) )
                                if( snobold->GetTypeId() == TYPEID_UNIT )
                                {
                                    bool needDespawn = true;
                                    for( uint8 i = 0; i < 4; ++i )
                                        if( !vk->GetPassenger(i) )
                                        {
                                            snobold->ChangeSeat(i);
                                            needDespawn = false;
                                            break;
                                        }
                                    if( needDespawn )
                                        snobold->ToCreature()->DespawnOrUnsummon();
                                }
                        }
                        PlayerGUID = 0;
                    }
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*pKiller*/)
        {
            summons.DoAction(1);

            if( pInstance )
                pInstance->SetData(TYPE_GORMOK, DONE);
        }

        void JustSummoned(Creature* summon)
        {
            summons.Summon(summon);
        }

        void DoAction(int32 param)
        {
            switch( param )
            {
                case -1:
                    summons.DespawnAll();
                    break;
            }
        }

        void EnterEvadeMode()
        {
            events.Reset();
            summons.DespawnAll();
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            if( pInstance )
                pInstance->SetData(TYPE_FAILED, 1);
        }
    };
};


/***********
** ACIDMAW AND DREADSCALE
***********/

enum JormungarSpells
{
    SPELL_ACID_SPIT                     = 66880,
    SPELL_ACID_SPEW                     = 66818,
    SPELL_PARALYTIC_SPRAY               = 66901,
    SPELL_PARALYTIC_BITE                = 66824,

    SPELL_FIRE_SPIT                     = 66796,
    SPELL_MOLTEN_SPEW                   = 66821,
    SPELL_BURNING_SPRAY                 = 66902,
    SPELL_BURNING_BITE                  = 66879,

    SUMMON_SLIME_POOL                   = 66883,
    SPELL_SLIME_POOL_EFFECT             = 66882,
    SPELL_SWEEP_0                       = 66794,
    SPELL_SWEEP_1                       = 67646,

    SPELL_EMERGE_0                      = 66947,
    SPELL_SUBMERGE_0                    = 53421,
    SPELL_ENRAGE                        = 68335,
    SPELL_CHURNING_GROUND               = 66969,
};

enum Model
{
    MODEL_ACIDMAW_STATIONARY            = 29815,
    MODEL_ACIDMAW_MOBILE                = 29816,
    MODEL_DREADSCALE_STATIONARY         = 26935,
    MODEL_DREADSCALE_MOBILE             = 24564,
};

enum JormungarNPCs
{
    NPC_SLIME_POOL                      = 35176,
};

enum JormungarEvents
{
    EVENT_SUBMERGE = 1,
    EVENT_EMERGE,
    EVENT_MOVE_UNDERGROUND,

    EVENT_SPELL_SPRAY,
    EVENT_SPELL_SWEEP,
    EVENT_SPELL_BITE,
    EVENT_SPELL_SPEW,
    EVENT_SPELL_SLIME_POOL,
};

struct boss_jormungarAI : public ScriptedAI
{
    boss_jormungarAI(Creature* pCreature) : ScriptedAI(pCreature)
    {
        pInstance = pCreature->GetInstanceScript();
        me->SetReactState(REACT_PASSIVE);
    }

    InstanceScript* pInstance;
    EventMap events;
    bool bIsStationary;

    uint32 _SPELL_BITE;
    uint32 _SPELL_SPEW;
    uint32 _SPELL_SPIT;
    uint32 _SPELL_SPRAY;
    uint32 _MODEL_STATIONARY;
    uint32 _MODEL_MOBILE;
    uint32 _TYPE_OTHER;

    void DoAction(int32 param)
    {
        switch( param )
        {
            case -1:
                if( !me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE) )
                    events.RescheduleEvent(EVENT_SUBMERGE, 1500);
                break;
            case -2:
                if( me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE) )
                    bIsStationary = true; // it will come out mobile soon
                else if( me->GetDisplayId() == _MODEL_STATIONARY )
                    events.RescheduleEvent(EVENT_SUBMERGE, 1000);
                else
                    events.CancelEvent(EVENT_SUBMERGE);
                me->CastSpell(me, SPELL_ENRAGE, true);
                Talk(EMOTE_ENRAGE);
                break;
        }
    }

    void ScheduleEvents()
    {
        events.Reset();
        if( me->GetDisplayId() == _MODEL_STATIONARY )
        {
            me->SetAttackTime(BASE_ATTACK, 1500);
            events.RescheduleEvent(EVENT_SPELL_SPRAY, (me->GetEntry() == NPC_ACIDMAW ? 20000 : 15000));
            events.RescheduleEvent(EVENT_SPELL_SWEEP, urand(15000, 30000));
        }
        else
        {
            me->SetAttackTime(BASE_ATTACK, 2000);
            events.RescheduleEvent(EVENT_SPELL_BITE, (me->GetEntry() == NPC_ACIDMAW ? 20000 : 15000));
            events.RescheduleEvent(EVENT_SPELL_SPEW, urand(15000, 30000));
            events.RescheduleEvent(EVENT_SPELL_SLIME_POOL, 15000);
        }
        if( !me->HasAura(SPELL_ENRAGE) )
            events.RescheduleEvent(EVENT_SUBMERGE, urand(45000, 50000));
    }

    void EnterCombat(Unit* /*who*/)
    {
        me->setActive(true);
        ScheduleEvents();
    }

    void JustReachedHome()
    {
        me->setActive(false);
    }

    void AttackStart(Unit* who)
    {
        if( me->GetDisplayId() == _MODEL_STATIONARY )
        {
            if( !who )
                return;
            if( me->Attack(who, true) )
                DoStartNoMovement(who);
        }
        else
            ScriptedAI::AttackStart(who);
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
            case EVENT_SUBMERGE:
                {
                    bIsStationary = (me->GetDisplayId() == _MODEL_STATIONARY);
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                    me->CastSpell(me, SPELL_SUBMERGE_0, false);
                    Talk(EMOTE_SUBMERGE);

                    // second one submerge 1.5sec after the first one, used also for synchronizing
                    if( pInstance )
                        if( Creature* c = ObjectAccessor::GetCreature(*me, pInstance->GetData64(_TYPE_OTHER)) )
                            c->AI()->DoAction(-1);

                    events.Reset();
                    events.RescheduleEvent(EVENT_MOVE_UNDERGROUND, 2500);
                }
                break;
            case EVENT_MOVE_UNDERGROUND:
                {
                    float angle = me->GetAngle(Locs[LOC_CENTER].GetPositionX() + urand(0, 20) - 10.0f, Locs[LOC_CENTER].GetPositionY() + urand(0, 20) - 10.0f), dist = urand(10, 35);
                    if( Creature* c = me->SummonCreature(NPC_WORLD_TRIGGER, *me, TEMPSUMMON_TIMED_DESPAWN, 6000) )
                    {
                        c->SetSpeed(MOVE_RUN, 2.5f);
                        c->CastSpell(c, SPELL_CHURNING_GROUND, true);
                        c->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_PACIFIED);
                        c->GetMotionMaster()->MovePoint(0, Locs[LOC_CENTER].GetPositionX() + cos(angle)*dist, Locs[LOC_CENTER].GetPositionY() + sin(angle)*dist, me->GetPositionZ());
                    }
                    me->UpdatePosition(Locs[LOC_CENTER].GetPositionX() + cos(angle)*dist, Locs[LOC_CENTER].GetPositionY() + sin(angle)*dist, me->GetPositionZ(), me->GetOrientation(), true);
                    me->StopMovingOnCurrentPos();
                    DoResetThreat();
                    
                    events.RescheduleEvent(EVENT_EMERGE, 6000);
                }
                break;
            case EVENT_EMERGE:
                {
                    me->GetMotionMaster()->Clear();
                    me->GetMotionMaster()->MoveIdle();
                    me->StopMoving();
                    if( bIsStationary )
                    {
                        me->SetNativeDisplayId(_MODEL_MOBILE);
                        SetCombatMovement(true);
                        if( Unit* victim = me->GetVictim() )
                            me->GetMotionMaster()->MoveChase(victim);
                    }
                    else
                    {
                        me->SetNativeDisplayId(_MODEL_STATIONARY);
                        SetCombatMovement(false);
                    }
                    me->RemoveAurasDueToSpell(SPELL_SUBMERGE_0);
                    me->CastSpell(me, SPELL_EMERGE_0, false);
                    Talk(EMOTE_EMERGE);
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                    ScheduleEvents();
                }
                break;
            case EVENT_SPELL_SPRAY:
                if( Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100.0f, true) )
                    me->CastSpell(target, _SPELL_SPRAY, false);
                events.RepeatEvent(20000);
                break;
            case EVENT_SPELL_SWEEP:
                me->CastSpell((Unit*)NULL, SPELL_SWEEP_0, false);
                events.RepeatEvent(urand(15000, 30000));
                break;
            case EVENT_SPELL_BITE:
                if( Unit* victim = me->GetVictim() )
                    me->CastSpell(victim, _SPELL_BITE, false);
                events.RepeatEvent(20000);
                break;
            case EVENT_SPELL_SPEW:
                me->CastSpell(me->GetVictim(), _SPELL_SPEW, false);
                events.RepeatEvent(urand(15000, 30000));
                break;
            case EVENT_SPELL_SLIME_POOL:
                if( Creature* c = me->SummonCreature(NPC_SLIME_POOL, *me, TEMPSUMMON_TIMED_DESPAWN, 30000) )
                    c->CastSpell(c, SPELL_SLIME_POOL_EFFECT, true);
                events.RepeatEvent(30000);
                break;
        }

        if( !me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE) )
        {
            if( me->GetDisplayId() == _MODEL_STATIONARY )
                DoSpellAttackIfReady(_SPELL_SPIT);
            else
                DoMeleeAttackIfReady();
        }
    }

    void JustDied(Unit* /*pKiller*/)
    {
        if( pInstance )
        {
            if( Creature* c = pInstance->instance->GetCreature(pInstance->GetData64(_TYPE_OTHER)) )
                if( c->IsAlive() )
                    c->AI()->DoAction(-2);
            pInstance->SetData(TYPE_JORMUNGAR, DONE);
        }
    }

    void EnterEvadeMode()
    {
        events.Reset();
        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
        if( pInstance )
            pInstance->SetData(TYPE_FAILED, 1);
    }
};

class boss_acidmaw : public CreatureScript
{
public:
    boss_acidmaw() : CreatureScript("boss_acidmaw") { }

    struct boss_acidmawAI : public boss_jormungarAI
    {
        boss_acidmawAI(Creature* pCreature) : boss_jormungarAI(pCreature)
        {
            _SPELL_BITE = SPELL_PARALYTIC_BITE;
            _SPELL_SPEW = SPELL_ACID_SPEW;
            _SPELL_SPIT = SPELL_ACID_SPIT;
            _SPELL_SPRAY = SPELL_PARALYTIC_SPRAY;
            _MODEL_STATIONARY = MODEL_ACIDMAW_STATIONARY;
            _MODEL_MOBILE = MODEL_ACIDMAW_MOBILE;
            _TYPE_OTHER = TYPE_DREADSCALE;
            SetCombatMovement(false);
        }
    };


    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_acidmawAI(creature);
    }
};

class boss_dreadscale : public CreatureScript
{
public:
    boss_dreadscale() : CreatureScript("boss_dreadscale") { }

    struct boss_dreadscaleAI : public boss_jormungarAI
    {
        boss_dreadscaleAI(Creature* pCreature) : boss_jormungarAI(pCreature)
        {
            _SPELL_BITE = SPELL_BURNING_BITE;
            _SPELL_SPEW = SPELL_MOLTEN_SPEW;
            _SPELL_SPIT = SPELL_FIRE_SPIT;
            _SPELL_SPRAY = SPELL_BURNING_SPRAY;
            _MODEL_STATIONARY = MODEL_DREADSCALE_STATIONARY;
            _MODEL_MOBILE = MODEL_DREADSCALE_MOBILE;
            _TYPE_OTHER = TYPE_ACIDMAW;
        }
    };

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_dreadscaleAI(pCreature);
    }
};


/***********
** ICEHOWL
***********/

enum IcehowlSpells
{
    SPELL_FEROCIOUS_BUTT                = 66770,
    SPELL_WHIRL                         = 67345,
    SPELL_ARCTIC_BREATH                 = 66689,

    SPELL_MASSIVE_CRASH                 = 66683,
    SPELL_JUMP_BACK                     = 66733,
    SPELL_TRAMPLE                       = 66734,
    SPELL_FROTHING_RAGE                 = 66759,
    SPELL_STAGGERED_DAZE                = 66758,
    SPELL_BERSERK                       = 26662,
    SPELL_SURGE_OF_ADRENALINE           = 68667,
};

enum IcehowlEvents
{
    EVENT_JUMP_MIDDLE = 1,
    EVENT_GAZE,
    EVENT_JUMP_BACK,
    EVENT_TRAMPLE,
    EVENT_CHECK_TRAMPLE_PLAYERS,
    EVENT_REFRESH_POSITION,
    EVENT_SPELL_FEROCIOUS_BUTT,
    EVENT_SPELL_MASSIVE_CRASH,
    EVENT_SPELL_WHIRL,
    EVENT_SPELL_ARCTIC_BREATH,
};

class boss_icehowl : public CreatureScript
{
public:
    boss_icehowl() : CreatureScript("boss_icehowl") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_icehowlAI(pCreature);
    }

    struct boss_icehowlAI : public ScriptedAI
    {
        boss_icehowlAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            pInstance = pCreature->GetInstanceScript();
            me->AddUnitMovementFlag(MOVEMENTFLAG_WALKING);
            me->SetReactState(REACT_PASSIVE);
            if (IsHeroic())
                me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_DISPEL, true);
            me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_DECREASE_SPEED, true);
            me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_SPEED_NOT_STACK, true);
            me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_SPEED_ALWAYS, true);
            me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_SPEED_SLOW_ALL, true);
            me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_USE_NORMAL_MOVEMENT_SPEED, true); // judgement of justice
            //me->SetLootMode(0); // [LOOT]
        }

        InstanceScript* pInstance;
        EventMap events;
        uint64 TargetGUID;
        float destX, destY, destZ;

        void AttackStart(Unit* who)
        {
            if (me->GetReactState() != REACT_PASSIVE)
                ScriptedAI::AttackStart(who);
        }

        void EnterCombat(Unit* /*who*/)
        {
            me->setActive(true);
            events.Reset();
            events.ScheduleEvent(EVENT_SPELL_FEROCIOUS_BUTT, urand(15000, 30000));
            events.RescheduleEvent(EVENT_SPELL_WHIRL, urand(10000, 12000));
            events.RescheduleEvent(EVENT_SPELL_ARCTIC_BREATH, 14000);
            events.RescheduleEvent(EVENT_JUMP_MIDDLE, 30000);
        }

        void JustReachedHome()
        {
            me->setActive(false);
        }

        bool DoTrampleIfValid()
        {
            Map::PlayerList const& lPlayers = me->GetMap()->GetPlayers();
            for( Map::PlayerList::const_iterator itr = lPlayers.begin(); itr != lPlayers.end(); ++itr )
                if( Unit* p = itr->GetSource() )
                    if( p->IsAlive() && p->GetExactDist(me) <= 12.0f )
                    {
                        DoCastAOE(SPELL_TRAMPLE);
                        return true;
                    }

            return false;
        }

        void MovementInform(uint32  /*type*/, uint32 id)
        {
            if( id == EVENT_CHARGE )
            {
                events.Reset();
                events.RescheduleEvent(EVENT_SPELL_FEROCIOUS_BUTT, urand(5000, 15000));
                events.RescheduleEvent(EVENT_SPELL_WHIRL, urand(2000, 5000));
                events.RescheduleEvent(EVENT_SPELL_ARCTIC_BREATH, urand(5000, 8000));
                events.RescheduleEvent(EVENT_JUMP_MIDDLE, urand(30000, 50000));

                float angle = me->GetAngle(&Locs[LOC_CENTER]);
                angle = angle >= M_PI ? angle - M_PI : angle + M_PI;

                me->UpdatePosition(destX, destY, destZ, angle, true);
                me->StopMovingOnCurrentPos();

                if( !DoTrampleIfValid() )
                {
                    me->CastSpell(me, SPELL_STAGGERED_DAZE, true);
                    me->CastSpell((Unit*)NULL, SPELL_TRAMPLE, true);
                    Talk(EMOTE_TRAMPLE_CRASH);
                    events.DelayEvents(15000);
                }
                else
                {
                    Talk(EMOTE_TRAMPLE_FAIL);
                    me->CastSpell(me, SPELL_FROTHING_RAGE, true);
                }

                me->SetReactState(REACT_AGGRESSIVE);
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
                case EVENT_SPELL_FEROCIOUS_BUTT:
                    if( Unit* victim = me->GetVictim() )
                        me->CastSpell(victim, SPELL_FEROCIOUS_BUTT, false);
                    events.RepeatEvent(urand(15000, 30000));
                    break;
                case EVENT_SPELL_WHIRL:
                    me->CastSpell((Unit*)NULL, SPELL_WHIRL, false);
                    events.RepeatEvent(urand(15000, 20000));
                    break;
                case EVENT_SPELL_ARCTIC_BREATH:
                    if( Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 90.0f, true) )
                        me->CastSpell(target, SPELL_ARCTIC_BREATH, false);
                    events.RepeatEvent(urand(20000, 30000));
                    break;
                case EVENT_JUMP_MIDDLE:
                    me->StopMoving();
                    me->GetMotionMaster()->Clear();
                    me->GetMotionMaster()->MoveIdle();
                    me->SetReactState(REACT_PASSIVE);
                    me->AttackStop();
                    me->GetMotionMaster()->MoveJump(Locs[LOC_CENTER].GetPositionX(), Locs[LOC_CENTER].GetPositionY(), Locs[LOC_CENTER].GetPositionZ(), 40.0f, 12.0f);
                    me->SetUInt64Value(UNIT_FIELD_TARGET, 0);
                    events.Reset();
                    events.RescheduleEvent(EVENT_SPELL_MASSIVE_CRASH, 2000);
                    break;
                case EVENT_SPELL_MASSIVE_CRASH:
                    me->GetMotionMaster()->Clear();
                    me->CastSpell((Unit*)NULL, SPELL_MASSIVE_CRASH, false);
                    
                    events.RescheduleEvent(EVENT_GAZE, 2000);
                    break;
                case EVENT_GAZE:
                    if( Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 500.0f, true) )
                    {
                        TargetGUID = target->GetGUID();
                        me->SetUInt64Value(UNIT_FIELD_TARGET, TargetGUID);
                        me->SetFacingToObject(target);
                        Talk(EMOTE_TRAMPLE_STARE, target);
                        me->HandleEmoteCommand(EMOTE_ONESHOT_ROAR);
                        events.RescheduleEvent(EVENT_JUMP_BACK, 2000);
                    }
                    else // in case something went wrong
                    {
                        events.RescheduleEvent(EVENT_SPELL_FEROCIOUS_BUTT, urand(5000, 15000));
                        events.RescheduleEvent(EVENT_SPELL_WHIRL, urand(2000, 5000));
                        events.RescheduleEvent(EVENT_SPELL_ARCTIC_BREATH, urand(5000, 8000));
                        events.RescheduleEvent(EVENT_JUMP_MIDDLE, urand(30000, 50000));
                        me->GetMotionMaster()->MovementExpired();
                        me->SetReactState(REACT_AGGRESSIVE);
                    }
                    
                    break;
                case EVENT_JUMP_BACK:
                    {
                        float angle;
                        if( Unit* target = ObjectAccessor::GetPlayer(*me, TargetGUID) )
                            angle = me->GetAngle(target);
                        else // in case something went wrong
                            angle = rand_norm() * 2 * M_PI;

                        float jumpangle = angle >= M_PI ? angle - M_PI : angle + M_PI;
                        float dist = 50.0f;
                        if( angle > 1.0f && angle < 2.0f ) // near main gate
                            dist = 46.0f;
                        destX = Locs[LOC_CENTER].GetPositionX() + cos(angle) * dist;
                        destY = Locs[LOC_CENTER].GetPositionY() + sin(angle) * dist;
                        destZ = Locs[LOC_CENTER].GetPositionZ() + 1.0f;
                        me->StopMoving();
                        me->GetMotionMaster()->MoveJump(Locs[LOC_CENTER].GetPositionX() + cos(jumpangle) * 35.0f, Locs[LOC_CENTER].GetPositionY() + sin(jumpangle) * 35.0f, Locs[LOC_CENTER].GetPositionZ() + 1.0f, 40.0f, 12.0f);

                        events.RescheduleEvent(EVENT_TRAMPLE, 1500);

                        if( pInstance )
                            switch( GetDifficulty() )
                            {
                                case RAID_DIFFICULTY_10MAN_NORMAL:
                                    pInstance->DoRemoveAurasDueToSpellOnPlayers(SPELL_MASSIVE_CRASH);
                                    pInstance->DoCastSpellOnPlayers(SPELL_SURGE_OF_ADRENALINE);
                                    break;
                                case RAID_DIFFICULTY_25MAN_NORMAL:
                                    pInstance->DoRemoveAurasDueToSpellOnPlayers(67660);
                                    pInstance->DoCastSpellOnPlayers(SPELL_SURGE_OF_ADRENALINE);
                                    break;
                                case RAID_DIFFICULTY_10MAN_HEROIC:
                                    pInstance->DoRemoveAurasDueToSpellOnPlayers(67661);
                                    break;
                                case RAID_DIFFICULTY_25MAN_HEROIC:
                                    pInstance->DoRemoveAurasDueToSpellOnPlayers(67662);
                                    break;
                            }
                    }
                    break;
                case EVENT_TRAMPLE:
                    //Talk(EMOTE_TRAMPLE_START);
                    me->DisableSpline();
                    me->GetMotionMaster()->Clear();
                    me->GetMotionMaster()->MoveCharge(destX, destY, destZ + 1.0f, 65.0f);
                    me->SetUInt64Value(UNIT_FIELD_TARGET, 0);
                    events.RescheduleEvent(EVENT_CHECK_TRAMPLE_PLAYERS, 100);
                    
                    break;
                case EVENT_CHECK_TRAMPLE_PLAYERS:
                    if( DoTrampleIfValid() )
                    {
                        events.Reset();
                        events.RescheduleEvent(EVENT_SPELL_FEROCIOUS_BUTT, urand(5000, 15000));
                        events.RescheduleEvent(EVENT_SPELL_WHIRL, urand(2000, 5000));
                        events.RescheduleEvent(EVENT_SPELL_ARCTIC_BREATH, urand(5000, 8000));
                        events.RescheduleEvent(EVENT_JUMP_MIDDLE, urand(30000, 50000));
                        Talk(EMOTE_TRAMPLE_FAIL);
                        me->CastSpell(me, SPELL_FROTHING_RAGE, true);
                        me->GetMotionMaster()->MovementExpired();
                        me->SetReactState(REACT_AGGRESSIVE);
                    }
                    // no PopEvent() intended!
                    break;
                case EVENT_REFRESH_POSITION:
                    //me->SetFacingTo(me->GetOrientation());
                    
                    break;
            }

            if( me->GetReactState() != REACT_PASSIVE )
                DoMeleeAttackIfReady();
        }

        void EnterEvadeMode()
        {
            events.Reset();
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            if( pInstance )
                pInstance->SetData(TYPE_FAILED, 1);
        }

        void JustDied(Unit* /*killer*/)
        {
            if( !pInstance )
                return;

            pInstance->SetData(TYPE_ICEHOWL, DONE);

            Player* plr = nullptr;
            if( !pInstance->instance->GetPlayers().isEmpty() )
                plr = pInstance->instance->GetPlayers().begin()->GetSource();

            if( !plr )
                return;

            // remove loot for the other faction (items are invisible for players, done in conditions), so corpse can be skinned
            for( std::vector<LootItem>::iterator itr = me->loot.items.begin(); itr != me->loot.items.end(); ++itr )
                if( ItemTemplate const* iProto = sObjectMgr->GetItemTemplate((*itr).itemid) )
                    if( ((iProto->Flags2 & ITEM_FLAGS_EXTRA_HORDE_ONLY) && plr->GetTeamId() != TEAM_HORDE) || ((iProto->Flags2 & ITEM_FLAGS_EXTRA_ALLIANCE_ONLY) && plr->GetTeamId() != TEAM_ALLIANCE) )
                    {
                        (*itr).count = 0;
                        (*itr).is_looted = true;
                        --me->loot.unlootedCount;
                    }
        }
    };
};


void AddSC_boss_northrend_beasts()
{
    new boss_gormok();
    new npc_snobold_vassal();

    new boss_acidmaw();
    new boss_dreadscale();

    new boss_icehowl();
}
