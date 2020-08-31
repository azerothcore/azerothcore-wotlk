/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "oculus.h"
#include "SpellInfo.h"

enum Spells
{
    SPELL_EVOCATION                             = 51602,
    SPELL_SUMMON_MENAGERIE_1                    = 50476,
    SPELL_SUMMON_MENAGERIE_2                    = 50495,
    SPELL_SUMMON_MENAGERIE_3                    = 50496,
    SPELL_TELEPORT                              = 51112,

    SPELL_FROSTBOMB                             = 51103,
    SPELL_TIME_BOMB_N                           = 51121,
    SPELL_TIME_BOMB_H                           = 59376,
    SPELL_EMPOWERED_ARCANE_EXPLOSION_N          = 51110,
    SPELL_EMPOWERED_ARCANE_EXPLOSION_H          = 59377,
};

#define SPELL_EMPOWERED_ARCANE_EXPLOSION        DUNGEON_MODE(SPELL_EMPOWERED_ARCANE_EXPLOSION_N, SPELL_EMPOWERED_ARCANE_EXPLOSION_H)
#define SPELL_TIME_BOMB                         DUNGEON_MODE(SPELL_TIME_BOMB_N, SPELL_TIME_BOMB_H)

enum UromNPCs
{
    NPC_PHANTASMAL_CLOUDSCRAPER                 = 27645,
    NPC_PHANTASMAL_MAMMOTH                      = 27642,
    NPC_PHANTASMAL_WOLF                         = 27644,

    NPC_PHANTASMAL_AIR                          = 27650,
    NPC_PHANTASMAL_FIRE                         = 27651,
    NPC_PHANTASMAL_WATER                        = 27653,

    NPC_PHANTASMAL_MURLOC                       = 27649,
    NPC_PHANTASMAL_NAGAL                        = 27648,
    NPC_PHANTASMAL_OGRE                         = 27647,
};

enum Events
{
    EVENT_FROSTBOMB                             = 1,
    EVENT_TELEPORT_TO_CENTER                    = 2,
    EVENT_TELE_BACK                             = 3,
    EVENT_TIME_BOMB                             = 4,
};

enum Yells
{
    SAY_SUMMON_1                                  = 0,
    SAY_SUMMON_2                                  = 1,
    SAY_SUMMON_3                                  = 2,
    SAY_AGGRO                                     = 3,
    EMOTE_ARCANE_EXPLOSION                        = 4,
    SAY_ARCANE_EXPLOSION                          = 5,
    SAY_DEATH                                     = 6,
    SAY_PLAYER_KILL                               = 7
};

float summons[3][4] =   {
                            {NPC_PHANTASMAL_AIR, NPC_PHANTASMAL_AIR, NPC_PHANTASMAL_WATER, NPC_PHANTASMAL_FIRE},
                            {NPC_PHANTASMAL_OGRE, NPC_PHANTASMAL_OGRE, NPC_PHANTASMAL_NAGAL, NPC_PHANTASMAL_MURLOC},
                            {NPC_PHANTASMAL_CLOUDSCRAPER, NPC_PHANTASMAL_CLOUDSCRAPER, NPC_PHANTASMAL_MAMMOTH, NPC_PHANTASMAL_WOLF}
                        };

float cords[4][4] =     {
                            {1177.47f, 937.722f, 527.405f, 2.21657f},
                            {968.66f, 1042.53f, 527.32f, 0.077f},
                            {1164.02f, 1170.85f, 527.321f, 3.66f},
                            {1118.31f, 1080.377f, 508.361f, 4.25f}
                        };

class boss_urom : public CreatureScript
{
public:
    boss_urom() : CreatureScript("boss_urom") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_uromAI (pCreature);
    }

    struct boss_uromAI : public ScriptedAI
    {
        boss_uromAI(Creature *c) : ScriptedAI(c)
        {
            pInstance = c->GetInstanceScript();
        }
        
        InstanceScript* pInstance;
        EventMap events;
        bool lock;
        float x,y,z;
        int32 releaseLockTimer;

        uint8 GetPhaseByCurrentPosition()
        {
            for (uint8 i=0; i<4; ++i)
                if (me->GetDistance(cords[i][0], cords[i][1], cords[i][2]) < 20.0f)
                    return i;

            return 0;
        }

        void Reset()
        {
            if (pInstance)
            {
                pInstance->SetData(DATA_UROM, NOT_STARTED);
                if( pInstance->GetData(DATA_VAROS) != DONE )
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                else
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            }

            me->CastSpell(me, SPELL_EVOCATION, true);
            events.Reset();
            lock = false;
            x = 0.0f;
            y = 0.0f;
            z = 0.0f;
            releaseLockTimer = 0;
            me->ApplySpellImmune(0, IMMUNITY_ID, 49838, true);
        }

        void EnterCombat(Unit* /*who*/)
        {
            if( lock )
                return;

            uint8 phase = GetPhaseByCurrentPosition();
            if( phase == 3 )
            {
                Talk(SAY_AGGRO);

                if( pInstance )
                    pInstance->SetData(DATA_UROM, IN_PROGRESS);

                me->SetInCombatWithZone();
                me->SetHomePosition(cords[0][0], cords[0][1], cords[0][2], cords[0][3]);
                if( me->FindCurrentSpellBySpellId(SPELL_EVOCATION) )
                    me->InterruptNonMeleeSpells(false);

                events.RescheduleEvent(EVENT_FROSTBOMB, urand(7000, 11000));
                events.RescheduleEvent(EVENT_TELEPORT_TO_CENTER, urand(30000, 35000));
                events.RescheduleEvent(EVENT_TIME_BOMB, urand(20000, 25000));
            }
            else
            {
                lock = true;

                switch( phase )
                {
                    case 0:
                        Talk(SAY_SUMMON_1);
                        me->InterruptNonMeleeSpells(false);
                        me->CastSpell(me, SPELL_SUMMON_MENAGERIE_1, false);
                        break;
                    case 1:
                        Talk(SAY_SUMMON_2);
                        me->InterruptNonMeleeSpells(false);
                        me->CastSpell(me, SPELL_SUMMON_MENAGERIE_2, false);
                        break;
                    case 2:
                        Talk(SAY_SUMMON_3);
                        me->InterruptNonMeleeSpells(false);
                        me->CastSpell(me, SPELL_SUMMON_MENAGERIE_3, false);
                        break;
                }
            }
        }

        void AttackStart(Unit* who)
        {
            if( lock )
                return;

            if (me->GetDistance(1103.0f, 1049.0f, 510.0f) < 55.0f)
                ScriptedAI::AttackStart(who);
        }

        void JustSummoned(Creature* pSummon)
        {
            pSummon->SetInCombatWithZone();
            if( Unit* v = pSummon->SelectVictim() )
                if( pSummon->AI() )
                    pSummon->AI()->AttackStart(v);
        }

        void LeaveCombat()
        {
            me->RemoveAllAuras();
            me->DeleteThreatList();
            me->CombatStop(true);
            me->LoadCreaturesAddon(true);
            me->SetLootRecipient(nullptr);
            me->ResetPlayerDamageReq();
        }

        void JustDied(Unit* /*killer*/)
        {
            Talk(SAY_DEATH);

            if (pInstance)
                pInstance->SetData(DATA_UROM, DONE);
        }

        void KilledUnit(Unit* /*victim*/)
        {
            Talk(SAY_PLAYER_KILL);
        }

        void SpellHit(Unit* /*caster*/, const SpellInfo* spell)
        {
            switch( spell->Id )
            {
                case SPELL_SUMMON_MENAGERIE_1:
                {
                    for( uint8 i=0; i<4; ++i )
						me->SummonCreature(summons[0][i], cords[0][0] + ((i%2) ? 4.0f : -4.0f), cords[0][1] + (i<2 ? 4.0f : -4.0f), cords[0][2], 0.0f, TEMPSUMMON_TIMED_DESPAWN, 300000);
                        uint8 phase = GetPhaseByCurrentPosition();
						me->SetHomePosition(cords[phase+1][0], cords[phase+1][1], cords[phase+1][2], cords[phase+1][3]);
						me->DestroyForNearbyPlayers();
                        LeaveCombat();
						me->CastSpell(me, SPELL_EVOCATION, true);
						releaseLockTimer = 1;
                }
                break;
                case SPELL_SUMMON_MENAGERIE_2:
                {
                    for( uint8 i=0; i<4; ++i )
						me->SummonCreature(summons[1][i], cords[1][0] + ((i%2) ? 4.0f : -4.0f), cords[1][1] + (i<2 ? 4.0f : -4.0f), cords[1][2], 0.0f, TEMPSUMMON_TIMED_DESPAWN, 300000);
                        uint8 phase = GetPhaseByCurrentPosition();
						me->SetHomePosition(cords[phase+1][0], cords[phase+1][1], cords[phase+1][2], cords[phase+1][3]);
						me->DestroyForNearbyPlayers();
                        LeaveCombat();
						me->CastSpell(me, SPELL_EVOCATION, true);
						releaseLockTimer = 1;
                }
                break;                
                case SPELL_SUMMON_MENAGERIE_3:
                    {
                        for( uint8 i=0; i<4; ++i )
						me->SummonCreature(summons[2][i], cords[2][0] + ((i%2) ? 4.0f : -4.0f), cords[2][1] + (i<2 ? 4.0f : -4.0f), cords[2][2], 0.0f, TEMPSUMMON_TIMED_DESPAWN, 300000);
                        uint8 phase = GetPhaseByCurrentPosition();
                        me->SetHomePosition(cords[phase+1][0], cords[phase+1][1], cords[phase+1][2], cords[phase+1][3]);
                        me->DestroyForNearbyPlayers();
                        LeaveCombat();
                        me->CastSpell(me, SPELL_EVOCATION, true);
                        releaseLockTimer = 1;
                    }
                    break;
                case SPELL_TELEPORT:
                    me->GetMotionMaster()->Clear();
                    me->GetMotionMaster()->MoveIdle();
                    me->StopMoving();
                    me->SetControlled(true, UNIT_STATE_ROOT);
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    me->SetCanFly(true);
                    me->SetDisableGravity(true);
                    me->NearTeleportTo(1103.69f, 1048.76f, 512.279f, 1.16f);
                    
                    Talk(SAY_ARCANE_EXPLOSION);
                    Talk(EMOTE_ARCANE_EXPLOSION);

                    //At this point we are still in casting state so we need to clear it for DoCastAOE not to fail
                    me->ClearUnitState(UNIT_STATE_CASTING);
                    DoCastAOE(DUNGEON_MODE(SPELL_EMPOWERED_ARCANE_EXPLOSION_N, SPELL_EMPOWERED_ARCANE_EXPLOSION_H));
                    me->AddUnitState(UNIT_STATE_CASTING);
                    events.RescheduleEvent(EVENT_TELE_BACK, DUNGEON_MODE(9000, 7000));
                default:
                    break;
            }
        }

        void MoveInLineOfSight(Unit* /*who*/) {}

        void UpdateAI(uint32 diff)
        {
            if( releaseLockTimer )
            {
                if( releaseLockTimer >= 5000 )
                {
                    lock = false;
                    if (me->IsInCombat())
                    {
                        LeaveCombat();
                        me->CastSpell(me, SPELL_EVOCATION, true);
                    }
                    releaseLockTimer = 0;
                }
                else
                    releaseLockTimer += diff;
            }

            if( !UpdateVictim() )
                return;

            events.Update(diff);

            if( me->HasUnitState(UNIT_STATE_CASTING) )
                return;

            DoMeleeAttackIfReady();

            switch( events.GetEvent() )
            {
                case 0:
                    break;
                case EVENT_FROSTBOMB:
                    if( Unit* v = me->GetVictim() )
                        me->CastSpell(v, SPELL_FROSTBOMB, false);
                    events.RepeatEvent(urand(7000,11000));
                    break;
                case EVENT_TIME_BOMB:
                    if( Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100.0f, true) )
                        DoCast(target, DUNGEON_MODE(SPELL_TIME_BOMB_N, SPELL_TIME_BOMB_H));
                    events.RepeatEvent(urand(20000, 25000));
                    break;
                case EVENT_TELEPORT_TO_CENTER:
                    x = me->GetPositionX();
                    y = me->GetPositionY();
                    z = me->GetPositionZ();
                    me->CastSpell(me, SPELL_TELEPORT, false);
                    events.RepeatEvent(urand(25000,30000));
                    events.DelayEvents(10000);
                    break;
                case EVENT_TELE_BACK:
                    me->GetMotionMaster()->MoveIdle();
                    me->DisableSpline();
                    me->SetCanFly(false);
                    me->SetDisableGravity(false);
                    me->NearTeleportTo(x, y, z, 0.0f);
                    me->SetControlled(false, UNIT_STATE_ROOT);
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    me->GetMotionMaster()->MoveChase(me->GetVictim());
                    events.PopEvent();
                    break;
            }
        }

        void EnterEvadeMode()
        {
            me->SetCanFly(false);
            me->SetDisableGravity(false);
            me->SetControlled(false, UNIT_STATE_ROOT);
            ScriptedAI::EnterEvadeMode();
        }
    };
};

void AddSC_boss_urom()
{
    new boss_urom();
}
