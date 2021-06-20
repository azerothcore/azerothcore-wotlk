/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "halls_of_stone.h"
#include "Player.h"

enum Spells
{
    // SJONNIR
    SPELL_FRENZY                            = 28747, //at 20% hp
    SPELL_CHAIN_LIGHTNING                   = 50830,
    SPELL_CHAIN_LIGHTNING_H                 = 59844,
    SPELL_LIGHTNING_SHIELD                  = 50831,
    SPELL_LIGHTNING_SHIELD_H                = 59845,
    SPELL_STATIC_CHARGE                     = 50834,
    SPELL_STATIC_CHARGE_H                   = 59846,
    SPELL_LIGHTNING_RING                    = 50840, 
    SPELL_LIGHTNING_RING_H                  = 59848,

    // IRON SLUDGE
    SPELL_TOXIC_VOLLEY                      = 50838,
    SPELL_TOXIC_VOLLEY_H                    = 59853,

    // FORGED IRON DWARF
    SPELL_LIGHTNING_TETHER                  = 50895,
    SPELL_LIGHTNING_TETHER_H                = 59851,

    // FORGED IRON TROGG
    SPELL_LIGHTNING_SHOCK                   = 50900,
    SPELL_LIGHTNING_SHOCK_H                 = 59852,
};

enum Npc
{
    NPC_IRON_SLUDGE                         = 28165, // if 2 ooze then spawn 1 iron_sludge
    NPC_DWARFES_FRIENDLY                    = 27980, //after fix the machine by Brann
    NPC_OOZE                                = 27981, //spawn after killing dwarf
    NPC_FORGED_IRON_DWARF                   = 27982,
    NPC_FORGED_IRON_TROGG                   = 27979,
};

enum Yells
{
    SAY_AGGRO                                              = 0,
    SAY_SLAY                                               = 1,
    SAY_DEATH                                              = 2
};

enum Events
{
    // SJONNIR
    EVENT_SHIELD                            = 1,
    EVENT_CHAIN_LIGHTNING                   = 2,
    EVENT_STATIC_CHARGE                     = 3,
    EVENT_LIGHTNING_RING                    = 4,
    EVENT_CHECK_HEALTH                      = 5,
    EVENT_SUMMON                            = 6,
    EVENT_SUMMON_SPEACH                     = 7,

    // TRASH
    EVENT_MALFORMED_OOZE_CHECK              = 10,
    EVENT_TOXIC_VOLLEY                      = 11,
    EVENT_FORGED_LIGHTNING_SHOCK            = 12,
    EVENT_FORGED_LIGHTNING_TETHER           = 13,
};

enum Misc
{
    POS_GEN_RIGHT                           = 0,
    POS_GEN_LEFT                            = 1,
    POS_ROOM_CENTER                         = 2,

    // ACTIONS
    ACTION_SLUG_KILLED                      = 1,
};

enum SummonPhases
{
    PHASE_SUMMON_UNFRIENDLY_DWARFES         = 0,
    PHASE_SUMMON_OOZE                       = 1,
    PHASE_SUMMON_FRIENDLY_DWARFES           = 2,
};

static Position RoomPosition[] =
{
    {1293.0f, 610.0f, 199.3f, 0.0f},
    {1294.2f, 724.3f, 199.3f, 0.0f},
    {1295.2f, 667.1f, 189.7f, 0.0f},
};

class boss_sjonnir : public CreatureScript
{
public:
    boss_sjonnir() : CreatureScript("boss_sjonnir") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_sjonnirAI (pCreature);
    }

    struct boss_sjonnirAI : public ScriptedAI
    {
        boss_sjonnirAI(Creature *c) : ScriptedAI(c), summons(me)
        {
            pInstance = c->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;
        SummonList summons;

        uint8 SummonPhase;
        uint8 SlugeCount;

        void Reset() 
        {
            events.Reset();
            summons.DespawnAll();

            SlugeCount = 0;
            SummonPhase = PHASE_SUMMON_UNFRIENDLY_DWARFES;

            if (pInstance) 
            {
                pInstance->SetData(BOSS_SJONNIR, NOT_STARTED);
                pInstance->SetData(DATA_SJONNIR_ACHIEVEMENT, false);
                
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                if (pInstance->GetData(BOSS_TRIBUNAL_OF_AGES) == DONE)
                {
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                    if (GameObject *doors = me->GetMap()->GetGameObject(pInstance->GetData64(GO_SJONNIR_DOOR)))
                        doors->SetGoState(GO_STATE_ACTIVE);

                    if (GameObject *console = me->GetMap()->GetGameObject( pInstance->GetData64(GO_SJONNIR_CONSOLE)))
                        console->SetGoState(GO_STATE_READY);

                    if (Creature *brann = ObjectAccessor::GetCreature(*me, pInstance->GetData64(NPC_BRANN)))
                    {
                        brann->setDeathState(JUST_DIED);
                        brann->Respawn();
                        brann->AI()->DoAction(5);
                    }
                }
            }
        }

        void EnterCombat(Unit*  /*who*/)
        {
            Talk(SAY_AGGRO);
            
            events.ScheduleEvent(EVENT_CHECK_HEALTH, 1000);
            events.ScheduleEvent(EVENT_SHIELD, 14000 + rand()%5000);
            events.ScheduleEvent(EVENT_CHAIN_LIGHTNING, 6000 + rand()%6000);
            events.ScheduleEvent(EVENT_STATIC_CHARGE, 24000);
            events.ScheduleEvent(EVENT_LIGHTNING_RING, 25000 + rand()%6000);
            events.ScheduleEvent(EVENT_SUMMON, 20000);
            events.ScheduleEvent(EVENT_SUMMON, 21500);
            events.ScheduleEvent(EVENT_SUMMON_SPEACH, 20000);

            if (pInstance)
            {
                pInstance->SetData(BOSS_SJONNIR, IN_PROGRESS);

                if (GameObject *doors = me->GetMap()->GetGameObject(pInstance->GetData64(GO_SJONNIR_DOOR)))
                    doors->SetGoState(GO_STATE_READY);
                    
                if (pInstance->GetData(BOSS_TRIBUNAL_OF_AGES) == DONE)
                    if (Creature *brann = ObjectAccessor::GetCreature(*me, pInstance->GetData64(NPC_BRANN)))
                        brann->AI()->DoAction(3);
            }
        }

        void DoAction(int32 param)
        {
            if (param == ACTION_SLUG_KILLED)
            {
                SlugeCount++;
                if (SlugeCount >= 5 && pInstance)
                    pInstance->SetData(DATA_SJONNIR_ACHIEVEMENT, true);
            }
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.GetEvent())
            {
                case EVENT_CHECK_HEALTH:
                {
                    if (SummonPhase == PHASE_SUMMON_UNFRIENDLY_DWARFES && HealthBelowPct(50)) 
                    {
                        SummonPhase = PHASE_SUMMON_OOZE;
                        events.CancelEvent(EVENT_SUMMON);
                        events.ScheduleEvent(EVENT_SUMMON, 0);
                        events.ScheduleEvent(EVENT_SUMMON, 1500);

                        if (pInstance)
                            if (Creature *brann = ObjectAccessor::GetCreature(*me, pInstance->GetData64(NPC_BRANN)))
                            {
                                brann->MonsterYell("What in the name o' Madoran did THAT do? Oh! Wait: I just about got it...", LANG_UNIVERSAL, 0);
                                brann->PlayDirectSound(14276);
                            }
                    }

                    if (HealthBelowPct(20))
                    {
                        if (Creature *brann = ObjectAccessor::GetCreature(*me, pInstance->GetData64(NPC_BRANN)))
                        {
                            brann->MonsterYell("Ha, that did it! Help's a-comin'! Take this, ya glowin' iron brute!", LANG_UNIVERSAL, 0);
                            brann->PlayDirectSound(14277);
                        }
                        SummonPhase = PHASE_SUMMON_FRIENDLY_DWARFES;
                        me->CastSpell(me, SPELL_FRENZY, false);

                        events.CancelEvent(EVENT_SUMMON);
                        events.ScheduleEvent(EVENT_SUMMON, 0);
                        events.PopEvent();
                        break;
                    }

                    events.RepeatEvent(1000);
                    break;
                }
                case EVENT_SHIELD:
                {
                    me->CastSpell(me, DUNGEON_MODE(SPELL_LIGHTNING_SHIELD, SPELL_LIGHTNING_SHIELD_H), false);
                    events.RepeatEvent(14000 + rand()%5000);
                    break;
                }
                case EVENT_CHAIN_LIGHTNING:
                {
                    if (Unit *target = SelectTarget(SELECT_TARGET_RANDOM, 0, 50.0f, true, 0))
                        me->CastSpell(target, DUNGEON_MODE(SPELL_CHAIN_LIGHTNING, SPELL_CHAIN_LIGHTNING_H), false);

                    events.RepeatEvent(6000 + rand()%6000);
                    break;
                }
                case EVENT_STATIC_CHARGE:
                {
                    if (Unit *target = SelectTarget(SELECT_TARGET_RANDOM, 0, 50.0f, true, 0))
                        me->CastSpell(target, DUNGEON_MODE(SPELL_STATIC_CHARGE, SPELL_STATIC_CHARGE_H), false);

                    events.RepeatEvent(20000);
                    break;
                }
                case EVENT_LIGHTNING_RING:
                {
                    me->CastSpell(me, DUNGEON_MODE(SPELL_LIGHTNING_RING, SPELL_LIGHTNING_RING_H), false);
                    events.RepeatEvent(25000 + rand()%6000);
                    events.DelayEvents(10000); // Channel duration
                    break;
                }
                case EVENT_SUMMON_SPEACH:
                {
                    if (Creature *brann = ObjectAccessor::GetCreature(*me, pInstance->GetData64(NPC_BRANN)))
                    {
                        brann->MonsterYell("This is a wee bit trickier that before... Oh, bloody--incomin'!", LANG_UNIVERSAL, 0);
                        brann->PlayDirectSound(14275);
                    }

                    events.PopEvent();
                    break;
                }
                case EVENT_SUMMON:
                {
                    switch (SummonPhase)
                    {
                        case PHASE_SUMMON_UNFRIENDLY_DWARFES:
                        {
                            SummonDwarfes(false);
                            events.RepeatEvent(20000);
                            break;
                        }
                        case PHASE_SUMMON_OOZE:
                        {
                            for (uint8 i = POS_GEN_RIGHT; i <= POS_GEN_LEFT; i++)
                            {
                                if (Creature* ooze = me->SummonCreature(NPC_OOZE, RoomPosition[i].GetPositionX(), RoomPosition[i].GetPositionY(), RoomPosition[i].GetPositionZ(), 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 20000))
                                {
                                    ActivatePipe(i);
                                    ooze->GetMotionMaster()->MovePoint(0, RoomPosition[POS_ROOM_CENTER].GetPositionX(), RoomPosition[POS_ROOM_CENTER].GetPositionY(), RoomPosition[POS_ROOM_CENTER].GetPositionZ());
                                    summons.Summon(ooze);
                                }
                            }
                            events.RepeatEvent(10000);
                            break;
                        }
                        case PHASE_SUMMON_FRIENDLY_DWARFES:
                        {
                            SummonDwarfes(true);
                            events.PopEvent();
                            break;
                        }
                    }
                    break;
                }
            }
            
            DoMeleeAttackIfReady();
        }

        void JustDied(Unit*  /*killer*/)
        {
            Talk(SAY_DEATH);

            summons.DespawnAll();
            if (pInstance)
            {
                pInstance->SetData(BOSS_SJONNIR, DONE);
                if (GameObject *sd = me->GetMap()->GetGameObject(pInstance->GetData64(GO_SJONNIR_DOOR)))
                    sd->SetGoState(GO_STATE_ACTIVE);

                if (Creature *brann = ObjectAccessor::GetCreature(*me, pInstance->GetData64(NPC_BRANN)))
                    brann->AI()->DoAction(4);
            }
        }

        void KilledUnit(Unit * /*victim*/)
        {
            if (urand(0,1))
                return;

            Talk(SAY_SLAY);
        }

        void ActivatePipe(uint8 side)
        {
            if (pInstance)
                if (GameObject *pipe = me->GetMap()->GetGameObject(pInstance->GetData64(side == POS_GEN_RIGHT ? GO_RIGHT_PIPE : GO_LEFT_PIPE)))
                    pipe->SendCustomAnim(0);
        }

        void SummonDwarfes(bool friendly)
        {
            if (friendly)
            {
                for (int i = 0; i < 3; i++)
                {
                    uint8 Pos = urand(POS_GEN_RIGHT, POS_GEN_LEFT);
                    if (Creature* dwarf = me->SummonCreature(NPC_DWARFES_FRIENDLY, RoomPosition[Pos].GetPositionX(), RoomPosition[Pos].GetPositionY() , RoomPosition[Pos].GetPositionZ(), 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 20000))
                    {
                        if (Player *plr = SelectTargetFromPlayerList(100.0f))
                            dwarf->setFaction(plr->getFaction());

                        ActivatePipe(Pos);
                        dwarf->AI()->AttackStart(me);
                        summons.Summon(dwarf);
                    }
                }
            }
            else
            {
                for (int i = 0; i < 2; i++)
                {
                    uint8 Pos = urand(POS_GEN_RIGHT, POS_GEN_LEFT);
                    if (Creature* dwarf = me->SummonCreature(urand(0,1) ? NPC_FORGED_IRON_TROGG : NPC_FORGED_IRON_DWARF, RoomPosition[Pos].GetPositionX(), RoomPosition[Pos].GetPositionY() , RoomPosition[Pos].GetPositionZ(), 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 20000))
                    {
                        ActivatePipe(Pos);
                        dwarf->SetInCombatWithZone();
                        summons.Summon(dwarf);
                    }
                }
            }
        }
    };
};

class boss_sjonnir_dwarf : public CreatureScript
{
public:
    boss_sjonnir_dwarf() : CreatureScript("boss_sjonnir_dwarf") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_sjonnir_dwarfAI (pCreature);
    }

    struct boss_sjonnir_dwarfAI : public ScriptedAI
    {
        boss_sjonnir_dwarfAI(Creature *c) : ScriptedAI(c) { }

        void UpdateAI(uint32  /*diff*/)
        {
            if (!UpdateVictim())
                return;             

            DoSpellAttackIfReady((me->GetEntry() == NPC_FORGED_IRON_DWARF) ? DUNGEON_MODE(SPELL_LIGHTNING_TETHER, SPELL_LIGHTNING_TETHER_H) : DUNGEON_MODE(SPELL_LIGHTNING_SHOCK, SPELL_LIGHTNING_SHOCK_H));
        }
    };
};

class boss_sjonnir_iron_sludge : public CreatureScript
{
public:
    boss_sjonnir_iron_sludge() : CreatureScript("boss_sjonnir_iron_sludge") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_sjonnir_iron_sludgeAI (pCreature);
    }

    struct boss_sjonnir_iron_sludgeAI : public ScriptedAI
    {
        boss_sjonnir_iron_sludgeAI(Creature *c) : ScriptedAI(c) { }
        
        EventMap events;
        void Reset() 
        {
            events.Reset();
        }

        void EnterCombat(Unit *)
        {
            events.ScheduleEvent(EVENT_TOXIC_VOLLEY, 5000);
        }
        void JustDied(Unit*  /*killer*/)
        {
            if (InstanceScript *pInstance = me->GetInstanceScript())
                if (Creature *sjonnir = ObjectAccessor::GetCreature(*me, pInstance->GetData64(NPC_SJONNIR)))
                    sjonnir->AI()->DoAction(ACTION_SLUG_KILLED);
        }
        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;             

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.GetEvent())
            {
                // Every 5 seconds
                case EVENT_TOXIC_VOLLEY:
                {
                    me->CastSpell(me, DUNGEON_MODE(SPELL_TOXIC_VOLLEY, SPELL_TOXIC_VOLLEY_H), false);
                    events.RepeatEvent(5000);
                    break;
                }
            }

            DoMeleeAttackIfReady();
        }
    };
};

//OOZE
class boss_sjonnir_malformed_ooze : public CreatureScript
{
public:
    boss_sjonnir_malformed_ooze() : CreatureScript("boss_sjonnir_malformed_ooze") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_sjonnir_malformed_oozeAI (pCreature);
    }

    struct boss_sjonnir_malformed_oozeAI : public ScriptedAI
    {
        boss_sjonnir_malformed_oozeAI(Creature *c) : ScriptedAI(c) {    }

        EventMap events;
        void MovementInform(uint32 type, uint32 point)
        {
            if (type == POINT_MOTION_TYPE && point == 0)
                events.RescheduleEvent(EVENT_MALFORMED_OOZE_CHECK, 1000);
        }

        void EnterCombat(Unit *) { }
        void MoveInLineOfSight(Unit *) { }

        void UpdateAI(uint32 diff)
        {
            events.Update(diff);
            switch (events.GetEvent())
            {
                case EVENT_MALFORMED_OOZE_CHECK:
                {
                    std::list<Creature*> oozeList;
                    me->GetCreaturesWithEntryInRange(oozeList, 5.0f, NPC_OOZE);
                    for (std::list<Creature*>::const_iterator itr = oozeList.begin(); itr != oozeList.end(); ++itr)
                        if ((*itr)->GetGUID() != me->GetGUID() && (*itr)->IsAlive() && me->IsAlive())
                            if (Creature* is = me->SummonCreature(NPC_IRON_SLUDGE, me->GetPositionX(), me->GetPositionY() , me->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 20000))
                            {
                                Unit::Kill(me, me);
                                Unit::Kill(*itr, *itr);
                                is->SetInCombatWithZone();
                                break;
                            }

                    events.RepeatEvent(1000);
                    break;
                }
            }
        }
    };
};

void AddSC_boss_sjonnir()
{
    new boss_sjonnir();
    new boss_sjonnir_dwarf();
    new boss_sjonnir_malformed_ooze();
    new boss_sjonnir_iron_sludge();
}