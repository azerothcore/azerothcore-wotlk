/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "SpellScript.h"
#include "ulduar.h"
#include "SpellAuras.h"
#include "PassiveAI.h"
#include "Player.h"
#include "WaypointManager.h"
#include "MoveSplineInit.h"

#define SPELL_FLAMEBUFFET_10                64016
#define SPELL_FLAMEBUFFET_25                64023
#define S_FLAMEBUFFET                       RAID_MODE(SPELL_FLAMEBUFFET_10, SPELL_FLAMEBUFFET_25)
#define SPELL_FIREBALL                      63815
#define SPELL_WINGBUFFET                    62666
#define SPELL_FLAMEBREATH_10                63317
#define SPELL_FLAMEBREATH_25                64021
#define S_FLAMEBREATH                       RAID_MODE(SPELL_FLAMEBREATH_10, SPELL_FLAMEBREATH_25)
#define SPELL_FUSEARMOR                     64771
#define SPELL_DEVOURINGFLAME                63236
#define SPELL_BERSERK                       47008

#define SPELL_CHAIN_1                       49679
#define SPELL_CHAIN_2                       49682
#define SPELL_CHAIN_3                       49683
#define SPELL_CHAIN_4                       49684
#define SPELL_LAUNCH_CHAIN                  62505
#define SPELL_HARPOON_SHOT_BUFF             62509
#define SPELL_HARPOON_FIRE_STATE            62696
#define REQ_CHAIN_COUNT                     RAID_MODE(2, 4)

#define SPELL_DEVOURINGFLAME_SUMMON         63308
#define SPELL_DEVOURINGFLAME_GROUNDAURA_10  64709
#define SPELL_DEVOURINGFLAME_GROUNDAURA_25  64734
#define S_DEVOURINGFLAME_GROUNDAURA         RAID_MODE(SPELL_DEVOURINGFLAME_GROUNDAURA_10, SPELL_DEVOURINGFLAME_GROUNDAURA_25)
#define NPC_DEVOURINGFLAME                  34188
#define SPELL_STORMSTRIKE                   51876
#define SPELL_WHIRLWIND                     63808
#define SPELL_LIGHTINGBOLT                  63809
#define SPELL_CHAINLIGHTNING                64758

#define NPC_DARK_RUNE_SENTINEL              33846
#define NPC_DARK_RUNE_GUARDIAN              33388
#define NPC_DARK_RUNE_WATCHER               33453
#define NPC_EXPEDITION_ENGINEER             33287
#define NPC_EXPEDITION_COMMANDER            33210
#define NPC_EXPEDITION_DEFENDER             33816
#define NPC_EXPEDITION_TRAPPER              33259
#define NPC_RAZORSCALE                      33186
#define NPC_HARPOON_FIRE_STATE              33282

#define GO_DRILL                            195305
#define GO_HARPOON_GUN_1                    194519
#define GO_HARPOON_GUN_2                    194541
#define GO_HARPOON_GUN_3                    194542
#define GO_HARPOON_GUN_4                    194543
#define GO_BROKEN_HARPOON                   194565

#define TEXT_GOSSIP_ACTION                  "We are ready to help!"
#define TEXT_EE_AGGRO                       "Give us a moment to prepare to build the turrets."
#define TEXT_EE_MOVE_OUT                    "Ready to move out, keep those dwarves off of our backs!"
#define TEXT_EE_FIRES_OUT                   "Fires out! Let's rebuild those turrets!"

#define TEXT_TURRET_READY                   "Harpoon Turret is ready for use!"
#define TEXT_DEEP_BREATH                    "Razorscale takes a deep breath..."
#define TEXT_GROUNDED_PERMANENTLY           "Razorscale grounded permanently!"


#define CORDS_GROUND                        588.0f, -166.0f, 391.1f
#define CORDS_AIR                           588.0f, -178.0f, 490.0f
#define REPAIR_POINTS                       25

enum eSay
{
    SAY_COMMANDER_INTRO             = 0,
    SAY_COMMANDER_GROUND            = 1,
    SAY_COMMANDER_AGGRO             = 2
};

enum eEvents
{
    EVENT_NONE = 0,
    EVENT_COMMANDER_SAY_AGGRO,
    EVENT_EE_SAY_MOVE_OUT,
    EVENT_ENRAGE,
    EVENT_SPELL_FIREBALL,
    EVENT_SPELL_DEVOURING_FLAME,
    EVENT_SUMMON_MOLE_MACHINES,
    EVENT_SUMMON_ADDS,
    EVENT_WARN_DEEP_BREATH,
    EVENT_PHASE2_FLAME_BREATH,
    EVENT_FLY_UP,
    EVENT_RESUME_FIXING,
    EVENT_SPELL_FLAME_BREATH,
    EVENT_SPELL_DEVOURING_FLAME_GROUND,
    EVENT_SPELL_FUSE_ARMOR,
    EVENT_SPELL_FLAME_BUFFET,
};

enum eMisc
{
    POINT_RAZORSCALE_INIT           = 1
};

class boss_razorscale : public CreatureScript
{
public:
    boss_razorscale() : CreatureScript("boss_razorscale") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_razorscaleAI (pCreature);
    }

    struct boss_razorscaleAI : public ScriptedAI
    {
        boss_razorscaleAI(Creature *pCreature) : ScriptedAI(pCreature), summons(me)
        {
            pInstance = me->GetInstanceScript();
            startPath = true;
        }

        InstanceScript* pInstance;
        EventMap events;
        SummonList summons;
        uint64 ExpeditionEngineerGUIDs[3];
        uint64 CommanderGUID;
        float cords[4][2];
        bool bGroundPhase;
        bool startPath;
        uint8 flyTimes;

        void Reset()
        {
            events.Reset();
            summons.DespawnAll();
            memset(&ExpeditionEngineerGUIDs, 0, sizeof(ExpeditionEngineerGUIDs));
            CommanderGUID = 0;
            bGroundPhase = false;
            flyTimes = 0;

            me->SetCanFly(true);
            me->SetDisableGravity(true);
            me->SetHover(true);
            me->SendMovementFlagUpdate();
            me->setActive(true);

            if( pInstance )
                pInstance->SetData(TYPE_RAZORSCALE, NOT_STARTED);
        }

        void AttackStart(Unit* who)
        {
            if (who && me->Attack(who, true) && bGroundPhase)
                me->GetMotionMaster()->MoveChase(who);
        }

        void EnterCombat(Unit*  /*who*/)
        {
            me->SetInCombatWithZone();
            events.Reset();
            events.ScheduleEvent(EVENT_COMMANDER_SAY_AGGRO, 5000);
            events.ScheduleEvent(EVENT_EE_SAY_MOVE_OUT, 10000);
            events.ScheduleEvent(EVENT_ENRAGE, 600000);
            events.ScheduleEvent(EVENT_SPELL_FIREBALL, 6000);
            events.ScheduleEvent(EVENT_SPELL_DEVOURING_FLAME, 13000);
            events.ScheduleEvent(EVENT_SUMMON_MOLE_MACHINES, 11000);

            std::list<Creature*> eeList;
            me->GetCreaturesWithEntryInRange(eeList, 300.0f, NPC_EXPEDITION_ENGINEER);
            uint8 i = 0;
            for( std::list<Creature*>::iterator itr = eeList.begin(); itr != eeList.end(); ++itr )
            {
                if( i > 2 )
                    break;
                ExpeditionEngineerGUIDs[i] = (*itr)->GetGUID();
                if (!i)
                    (*itr)->MonsterYell(TEXT_EE_AGGRO, LANG_UNIVERSAL, 0);
                ++i;
            }
            if (Creature* c = me->FindNearestCreature(NPC_EXPEDITION_COMMANDER, 300.0f, true))
                CommanderGUID = c->GetGUID();

            if( pInstance )
                pInstance->SetData(TYPE_RAZORSCALE, IN_PROGRESS);
        }

        void JustDied(Unit*  /*Killer*/)
        {
            summons.DespawnAll();

            if( pInstance )
                pInstance->SetData(TYPE_RAZORSCALE, DONE);
        }

        void SpellHit(Unit* caster, const SpellInfo* spell)
        {
            if (!caster || !pInstance)
                return;

            switch (spell->Id)
            {
                case SPELL_LAUNCH_CHAIN:
                    {
                        uint32 spell = 0;
                        if( caster->GetGUID() == pInstance->GetData64(DATA_HARPOON_FIRE_STATE_1) )
                            spell = SPELL_CHAIN_1;
                        else if( caster->GetGUID() == pInstance->GetData64(DATA_HARPOON_FIRE_STATE_2) )
                            spell = SPELL_CHAIN_2;
                        else if( caster->GetGUID() == pInstance->GetData64(DATA_HARPOON_FIRE_STATE_3) )
                            spell = SPELL_CHAIN_3;
                        else
                            spell = SPELL_CHAIN_4;
                        caster->CastSpell(me, spell, true);
                    }
                    break;
                case SPELL_CHAIN_1:
                case SPELL_CHAIN_2:
                case SPELL_CHAIN_3:
                case SPELL_CHAIN_4:
                    {
                        uint8 count = 0;
                        if( me->HasAura(SPELL_CHAIN_1) )
                            count++;
                        if( me->HasAura(SPELL_CHAIN_3) )
                            count++;
                        if (RAID_MODE(0,1))
                        {
                            if( me->HasAura(SPELL_CHAIN_2) )
                                count++;
                            if( me->HasAura(SPELL_CHAIN_4) )
                                count++;
                        }
                        if( count >= REQ_CHAIN_COUNT )
                        {
                            if (Creature* commander = ObjectAccessor::GetCreature(*me, CommanderGUID))
                                commander->AI()->Talk(SAY_COMMANDER_GROUND);

                            me->InterruptNonMeleeSpells(true);
                            events.CancelEvent(EVENT_SPELL_FIREBALL);
                            events.CancelEvent(EVENT_SPELL_DEVOURING_FLAME);
                            events.CancelEvent(EVENT_SUMMON_MOLE_MACHINES);
                            me->SetTarget(0);
                            me->SendMeleeAttackStop(me->GetVictim());
                            me->GetMotionMaster()->MoveLand(0, CORDS_GROUND, 25.0f);
                        }
                    }
                    break;
            }
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType /*damagetype*/, SpellSchoolMask /*damageSchoolMask*/)
        {
            if (me->GetPositionZ() > 440.0f) // protection, razorscale is attackable (so harpoons can hit him, etc.), but should not receive dmg while in air
                damage = 0;
            else if (!bGroundPhase && ((me->GetHealth()*100)/me->GetMaxHealth() < 50) && me->HasAura(62794)) // already below 50%, but still in chains and stunned
                events.RescheduleEvent(EVENT_WARN_DEEP_BREATH, 0);
        }

        void MovementInform(uint32 type, uint32 id)
        {
            if (type == POINT_MOTION_TYPE && id == POINT_RAZORSCALE_INIT)
            {
                me->SetFacingTo(1.6f);
                return;
            }
            else if (type == ESCORT_MOTION_TYPE && me->movespline->Finalized() && !me->IsInCombat())
            {
                startPath = true;
                return;
            }

            if (type != EFFECT_MOTION_TYPE)
                return;
            if (id == 0) // landed
            {
                me->SetControlled(true, UNIT_STATE_ROOT);
                me->DisableRotate(true);
                me->SetOrientation((float)(M_PI+0.01)/2);
                me->SetFacingTo(M_PI/2);
                me->SetCanFly(false);
                me->SetDisableGravity(false);
                me->SetHover(false);
                me->CastSpell(me, 62794, true);
                events.ScheduleEvent(EVENT_WARN_DEEP_BREATH, 30000);
            }
            else if (id == 1) // flied up
            {
                events.ScheduleEvent(EVENT_SPELL_FIREBALL, 2000);
                events.ScheduleEvent(EVENT_SPELL_DEVOURING_FLAME, 4000);
                events.ScheduleEvent(EVENT_SUMMON_MOLE_MACHINES, 5000);
            }
        }

        void UpdateAI(uint32 diff)
        {
            if (startPath)
            {
                me->StopMoving();
                startPath = false;
                if (WaypointPath const* i_path = sWaypointMgr->GetPath(me->GetWaypointPath()))
                {
                    Movement::PointsArray pathPoints;
                    pathPoints.push_back(G3D::Vector3(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()));
                    for (uint8 i = 0; i < i_path->size(); ++i)
                    {
                        WaypointData const* node = i_path->at(i);
                        pathPoints.push_back(G3D::Vector3(node->x, node->y, node->z));
                    }
                    me->GetMotionMaster()->MoveSplinePath(&pathPoints);
                }
            }

            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.GetEvent())
            {
                case 0:
                    break;
                case EVENT_ENRAGE:
                    me->CastSpell(me, SPELL_BERSERK, true);
                    events.RepeatEvent(600000);
                    break;
                case EVENT_COMMANDER_SAY_AGGRO:
                    if (Creature* commander = ObjectAccessor::GetCreature(*me, CommanderGUID))
                        commander->AI()->Talk(SAY_COMMANDER_AGGRO);
                    events.PopEvent();
                    break;
                case EVENT_EE_SAY_MOVE_OUT:
                    for (uint8 i=0; i<3; ++i)
                        if (Creature* c = ObjectAccessor::GetCreature(*me, ExpeditionEngineerGUIDs[i]))
                        {
                            if (!i)
                                c->MonsterYell(TEXT_EE_MOVE_OUT, LANG_UNIVERSAL, 0);
                            c->AI()->SetData(1, 0); // start repairing
                        }
                    events.PopEvent();
                    break;
                case EVENT_SPELL_FIREBALL:
                    if( Unit *pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 200.0f, true) )
                        me->CastSpell(pTarget, SPELL_FIREBALL, false);
                    events.RepeatEvent(4000);
                    break;
                case EVENT_SPELL_DEVOURING_FLAME:
                    if( Unit *pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 200.0f, true) )
                        me->CastSpell(pTarget, SPELL_DEVOURINGFLAME, false);
                    events.RepeatEvent(13000);
                    break;
                case EVENT_SUMMON_MOLE_MACHINES:
                    {
                        memset(cords, '\0', sizeof(cords));
                        uint8 num = RAID_MODE( urand(2,3), urand(2,4) );
                        for( int i=0; i<num; ++i )
                        {
                            // X: (550, 625) Y: (-185, -230)
                            cords[i][0] = urand(550, 625);
                            cords[i][1] = -230 + rand()%45;
                            if( GameObject* drill = me->SummonGameObject(GO_DRILL, cords[i][0], cords[i][1], 391.1f, M_PI/4, 0.0f, 0.0f, 0.0f, 0.0f, 8) )
                            {
                                //drill->SetGoAnimProgress(0);
                                //drill->SetLootState(GO_READY);
                                //drill->UseDoorOrButton(8);
                                //drill->SetGoState(GO_STATE_READY);
                                drill->SetGoState(GO_STATE_ACTIVE);
                                drill->SetGoAnimProgress(0);
                            }
                        }
                        events.RepeatEvent(45000);
                        events.RescheduleEvent(EVENT_SUMMON_ADDS, 4000);
                    }
                    break;
                case EVENT_SUMMON_ADDS:
                    for( int i=0; i<4; ++i )
                    {
                        if( !cords[i][0] )
                            break;

                        uint8 opt;
                        uint8 r = urand(1,100);
                        if( r <= 30 ) opt = 1;
                        else if( r <= 65 ) opt = 2;
                        else opt = 3;

                        for( int j=0; j<4; ++j )
                        {
                            float x = cords[i][0] + 4.0f*cos(j*M_PI/2);
                            float y = cords[i][1] + 4.0f*sin(j*M_PI/2);

                            uint32 npc_entry = 0;
                            switch( opt )
                            {
                                case 1: if( j == 1 ) npc_entry = NPC_DARK_RUNE_SENTINEL; break;
                                case 2:
                                    switch( j )
                                    {
                                        case 1: npc_entry = NPC_DARK_RUNE_WATCHER; break;
                                        case 2: npc_entry = NPC_DARK_RUNE_GUARDIAN; break;
                                    }
                                    break;
                                default: // case 3:
                                    switch( j )
                                    {
                                        case 1: npc_entry = NPC_DARK_RUNE_WATCHER; break;
                                        case 2: npc_entry = NPC_DARK_RUNE_GUARDIAN; break;
                                        case 3: npc_entry = NPC_DARK_RUNE_GUARDIAN; break;
                                    }
                                    break;
                            }

                            if( npc_entry )
                                if (Creature* c = me->SummonCreature(npc_entry, x, y, 391.1f, j*M_PI/2, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000))
                                    DoZoneInCombat(c);

                        }
                    }
                    events.PopEvent();
                    break;
                case EVENT_WARN_DEEP_BREATH:
                    me->MonsterTextEmote(TEXT_DEEP_BREATH, 0, true);
                    me->RemoveAura(62794);
                    events.PopEvent();
                    events.ScheduleEvent(EVENT_PHASE2_FLAME_BREATH, 2500);
                    break;
                case EVENT_PHASE2_FLAME_BREATH:
                    me->CastSpell(me, S_FLAMEBREATH, true);
                    events.PopEvent();
                    events.ScheduleEvent(EVENT_FLY_UP, 2000);
                    break;
                case EVENT_FLY_UP:
                    me->SetInCombatWithZone(); // just in case
                    if (pInstance)
                        for( int i=0; i<4; ++i )
                            if( uint64 guid = pInstance->GetData64(DATA_HARPOON_FIRE_STATE_1 + i) )
                                if( Creature* hfs = ObjectAccessor::GetCreature(*me, guid) )
                                {
                                    me->SummonCreature(34188, hfs->GetPositionX(), hfs->GetPositionY(), hfs->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN, 22000);
                                    hfs->AI()->SetData(1, 0);
                                }

                    me->RemoveAura(SPELL_LAUNCH_CHAIN);
                    me->RemoveAura(SPELL_CHAIN_1);
                    me->RemoveAura(SPELL_CHAIN_3);
                    if (RAID_MODE(0,1))
                    {
                        me->RemoveAura(SPELL_CHAIN_2);
                        me->RemoveAura(SPELL_CHAIN_4);
                    }
                    me->CastSpell(me, SPELL_WINGBUFFET, true);

                    if( (me->GetHealth()*100) / me->GetMaxHealth() < 50 ) // start phase 3
                    {
                        me->SetControlled(false, UNIT_STATE_ROOT);
                        me->DisableRotate(false);
                        DoResetThreat();
                        Unit* target = SelectTarget(SELECT_TARGET_NEAREST, 0, 0.0, true);
                        if (!target)
                            target = me->SelectNearestPlayer(200.0f);
                        if (target)
                        {
                            AttackStart(target);
                            me->GetMotionMaster()->MoveChase(target);
                        }
                        bGroundPhase = true;
                        events.PopEvent();
                        events.CancelEvent(EVENT_SPELL_FIREBALL);
                        events.CancelEvent(EVENT_SPELL_DEVOURING_FLAME);
                        events.CancelEvent(EVENT_SUMMON_MOLE_MACHINES);

                        events.ScheduleEvent(EVENT_SPELL_FLAME_BREATH, 20000);
                        events.ScheduleEvent(EVENT_SPELL_DEVOURING_FLAME_GROUND, 5000);
                        events.ScheduleEvent(EVENT_SPELL_FUSE_ARMOR, 10000);
                        events.ScheduleEvent(EVENT_SPELL_FLAME_BUFFET, 3000);

                        break;
                    }
                    else
                    {
                        ++flyTimes;
                        me->SetControlled(false, UNIT_STATE_ROOT);
                        me->DisableRotate(false);
                        me->SendMeleeAttackStop(me->GetVictim());
                        me->GetMotionMaster()->MoveIdle();
                        me->StopMoving();
                        me->SetCanFly(true);
                        me->SetDisableGravity(true);
                        me->SetHover(true);
                        me->SendMovementFlagUpdate();
                        me->GetMotionMaster()->MoveTakeoff(1, CORDS_AIR, 25.0f);
                        events.ScheduleEvent(EVENT_RESUME_FIXING, 22000);
                    }

                    events.PopEvent();
                    break;
                case EVENT_RESUME_FIXING:
                    for (uint8 i=0; i<3; ++i)
                        if (Creature* c = ObjectAccessor::GetCreature(*me, ExpeditionEngineerGUIDs[i]))
                        {
                            if (!i)
                                c->MonsterYell(TEXT_EE_FIRES_OUT, LANG_UNIVERSAL, 0);
                            c->AI()->SetData(1, 0); // start repairing
                        }
                    events.PopEvent();
                    break;
                case EVENT_SPELL_FLAME_BREATH:
                    me->CastSpell(me->GetVictim(), S_FLAMEBREATH, false);
                    events.RepeatEvent(20000);
                    break;
                case EVENT_SPELL_DEVOURING_FLAME_GROUND:
                    me->CastSpell(me->GetVictim(), SPELL_DEVOURINGFLAME, false);
                    events.RepeatEvent(13000);
                    break;
                case EVENT_SPELL_FUSE_ARMOR:
                    if (Unit* victim = me->GetVictim())
                        if (me->IsWithinMeleeRange(victim))
                        {
                            me->CastSpell(victim, SPELL_FUSEARMOR, false);
                            if (Aura* aur = victim->GetAura(SPELL_FUSEARMOR))
                                if (aur->GetStackAmount() == 5)
                                    victim->CastSpell(victim, 64774, true);
                            events.RepeatEvent(10000);
                            break;
                        }
                    events.RepeatEvent(2000);
                    break;
                case EVENT_SPELL_FLAME_BUFFET:
                    me->CastSpell(me->GetVictim(), S_FLAMEBUFFET, false);
                    events.RepeatEvent(7000);
                    break;
            }

            if (bGroundPhase)
                DoMeleeAttackIfReady();
        }

        void MoveInLineOfSight(Unit* /*who*/) {}

        void JustReachedHome()
        {
            startPath = true;
        }

        void JustSummoned(Creature* s)
        {
            summons.Summon(s);
        }

        uint32 GetData(uint32 id) const
        {
            if (id == 1)
                return (flyTimes <= 1 ? 1 : 0);
            return 0;
        }

        void KilledUnit(Unit* victim)
        {
            if (victim && victim->GetEntry() == NPC_DARK_RUNE_GUARDIAN)
                if (pInstance)
                    pInstance->DoUpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_KILL_CREATURE, NPC_DARK_RUNE_GUARDIAN, 1, me);
        }

        void EnterEvadeMode()
        {
            me->SetControlled(false, UNIT_STATE_ROOT);
            me->DisableRotate(false);
            ScriptedAI::EnterEvadeMode();
        }
    };
};

class npc_ulduar_expedition_commander : public CreatureScript
{
    public:
        npc_ulduar_expedition_commander() : CreatureScript("npc_ulduar_expedition_commander") { }

        bool OnGossipHello(Player* player, Creature* creature) override
        {
            if (!player || !creature)
                return true;

            InstanceScript* instance = creature->GetInstanceScript();
            if (!instance)
                return true;

            if (instance->GetData(TYPE_RAZORSCALE) == DONE)
                return true;

            Creature* razorscale = ObjectAccessor::GetCreature(*creature, instance->GetData64(TYPE_RAZORSCALE));
            if (!razorscale || razorscale->IsInCombat())
                return true;

            AddGossipItemFor(player, GOSSIP_ICON_CHAT, TEXT_GOSSIP_ACTION, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
            SendGossipMenuFor(player, 40100, creature);
            return true;
        }

        bool OnGossipSelect(Player* player, Creature* creature, uint32  /*uiSender*/, uint32 uiAction) override
        {
            if (!player || !creature)
                return true;

            if (uiAction == GOSSIP_ACTION_INFO_DEF+1)
            {
                InstanceScript* instance = creature->GetInstanceScript();
                if (!instance || instance->GetData(TYPE_RAZORSCALE) == DONE)
                    return true;

                Creature* razorscale = ObjectAccessor::GetCreature(*creature, instance->GetData64(TYPE_RAZORSCALE));
                if (razorscale && !razorscale->IsInCombat())
                {
                    // reset npcs NPC_HARPOON_FIRE_STATE
                    for (uint8 i = 0; i < 4; ++i)
                        if (Creature* hfs = ObjectAccessor::GetCreature(*creature, instance->GetData64(DATA_HARPOON_FIRE_STATE_1 + i)))
                            hfs->AI()->SetData(1, 0);

                    if (razorscale->AI())
                    {
                        razorscale->AI()->AttackStart(player);
                        razorscale->GetMotionMaster()->MoveIdle();
                        razorscale->GetMotionMaster()->MovePoint(POINT_RAZORSCALE_INIT, 588.0f, -178.0f, 490.0f, false, false);
                    }
                }
            }

            player->PlayerTalkClass->SendCloseGossip();
            return true;
        }

        CreatureAI* GetAI(Creature* creature) const override
        {
            return GetInstanceAI<npc_ulduar_expedition_commanderAI>(creature);
        }

        struct npc_ulduar_expedition_commanderAI : public NullCreatureAI
        {
            npc_ulduar_expedition_commanderAI(Creature* creature) : NullCreatureAI(creature)
            {
                _instance = creature->GetInstanceScript();
                _introSpoken = _instance->GetData(TYPE_RAZORSCALE) == DONE;
                me->SetReactState(REACT_AGGRESSIVE);
            }

            void MoveInLineOfSight(Unit* who) override
            {
                if (_introSpoken)
                    return;

                if (who->GetTypeId() != TYPEID_PLAYER || me->GetExactDist2d(who) > 15.0f)
                    return;

                _introSpoken = true;
                Talk(SAY_COMMANDER_INTRO);
            }

        private:
            InstanceScript* _instance;
            bool _introSpoken;
        };
};

class npc_ulduar_harpoonfirestate : public CreatureScript
{
public:
    npc_ulduar_harpoonfirestate() : CreatureScript("npc_ulduar_harpoonfirestate") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_ulduar_harpoonfirestateAI (pCreature);
    }

    struct npc_ulduar_harpoonfirestateAI : public NullCreatureAI
    {
        npc_ulduar_harpoonfirestateAI(Creature *pCreature) : NullCreatureAI(pCreature)
        {
            pInstance = me->GetInstanceScript();
        }

        InstanceScript* pInstance;
        uint8 repairPoints;

        void Reset()
        {
            repairPoints = 0;
        }

        uint32 GetHarpoonGunIdForThisHFS()
        {
            if (pInstance)
            {
                if( me->GetGUID() == pInstance->GetData64(DATA_HARPOON_FIRE_STATE_1) )
                    return GO_HARPOON_GUN_1;
                else if( me->GetGUID() == pInstance->GetData64(DATA_HARPOON_FIRE_STATE_2) )
                    return GO_HARPOON_GUN_2;
                else if( me->GetGUID() == pInstance->GetData64(DATA_HARPOON_FIRE_STATE_3) )
                    return GO_HARPOON_GUN_3;
                else
                    return GO_HARPOON_GUN_4;
            }
            return 0;
        }

        void SetData(uint32 id, uint32 value)
        {
            switch (id)
            {
                case 1: // cleanup at the start of the fight
                    if (pInstance)
                    {
                        uint32 h_entry = GetHarpoonGunIdForThisHFS();
                        if( GameObject* wh = me->FindNearestGameObject(h_entry, 5.0f) )
                        {
                            wh->SetRespawnTime(0);
                            wh->Delete();
                        }
                        if( GameObject* bh = me->FindNearestGameObject(GO_BROKEN_HARPOON, 5.0f) )
                            if (bh->GetPhaseMask() != 1)
                                bh->SetPhaseMask(1, true);
                    }
                    Reset();
                    break;
                case 2: // repairing
                    if (repairPoints < REPAIR_POINTS)
                    {
                        if (++repairPoints >= REPAIR_POINTS)
                        {
                            if( GameObject* bh = me->FindNearestGameObject(GO_BROKEN_HARPOON, 4.0f) )
                                bh->SetPhaseMask(2, true);
                            if( GameObject* wh = me->SummonGameObject(GetHarpoonGunIdForThisHFS(), me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 3*M_PI/2, 0.0f, 0.0f, 0.0f, 0.0f, 0) )
                            {
                                me->RemoveGameObject(wh, false);
                                me->MonsterTextEmote(TEXT_TURRET_READY, 0, true);
                            }
                        }
                    }
                    break;
                case 3: // shoot
                    if (pInstance)
                    {
                        Creature* razorscale = ObjectAccessor::GetCreature(*me, pInstance->GetData64(TYPE_RAZORSCALE));
                        if (!razorscale)
                            return;
                        if (!razorscale->HasAura(value))
                            me->CastSpell(razorscale, SPELL_LAUNCH_CHAIN, true);
                    }
                    break;
            }
        }

        uint32 GetData(uint32 id) const
        {
            switch (id)
            {
                case 2:
                    return (repairPoints >= REPAIR_POINTS ? 1 : 0);
            }
            return 0;
        }
    };
};

class npc_ulduar_expedition_engineer : public CreatureScript
{
public:
    npc_ulduar_expedition_engineer() : CreatureScript("npc_ulduar_expedition_engineer") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_ulduar_expedition_engineerAI (pCreature);
    }

    struct npc_ulduar_expedition_engineerAI : public NullCreatureAI
    {
        npc_ulduar_expedition_engineerAI(Creature *pCreature) : NullCreatureAI(pCreature)
        {
            pInstance = me->GetInstanceScript();
        }

        InstanceScript* pInstance;
        bool working;
        uint16 timer;
        uint64 fixingGUID;

        void Reset()
        {
            working = false;
            timer = 0;
            fixingGUID = 0;
        }

        void SetData(uint32 id, uint32  /*value*/)
        {
            switch (id)
            {
                case 1: // start/resume repairing
                    working = true;
                    timer = 0;
                    fixingGUID = 0;
                    break;
                case 2: // stop repairing
                    Reset();
                    me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_STAND);
                    me->GetMotionMaster()->MoveTargetedHome();
                    break;
            }
        }

        void UpdateAI(uint32 diff)
        {
            if (working)
            {
                if (timer <= diff)
                {
                    timer = 3000;

                    if (fixingGUID)
                    {
                        if (Creature* c = ObjectAccessor::GetCreature(*me, fixingGUID))
                            if (me->GetExactDist2dSq(c) <= 25.0f)
                            {
                                if( me->GetUInt32Value(UNIT_NPC_EMOTESTATE) != EMOTE_STATE_WORK )
                                    me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_WORK);

                                if (fabs(me->GetOrientation()-me->GetAngle(c)) > M_PI/4)
                                    me->SetFacingToObject(c);

                                c->AI()->SetData(2, 0);
                                if (c->AI()->GetData(2))
                                    fixingGUID = 0;
                            }
                    }

                    if (!fixingGUID)
                    {
                        Creature* razorscale = nullptr;
                        if( uint64 rsGUID = pInstance->GetData64(TYPE_RAZORSCALE) )
                            razorscale = ObjectAccessor::GetCreature(*me, rsGUID);

                        if( !razorscale || !razorscale->IsInCombat() )
                        {
                            Reset();
                            me->GetMotionMaster()->MoveTargetedHome();
                            return;
                        }

                        for( int i=0; i<4; ++i )
                            if( uint64 fs_GUID = pInstance->GetData64(DATA_HARPOON_FIRE_STATE_1 + i) )
                                if( Creature* fs = ObjectAccessor::GetCreature(*me, fs_GUID) )
                                    if (!fs->AI()->GetData(2))
                                        {
                                            float a = rand_norm()*M_PI;
                                            me->GetMotionMaster()->MovePoint(0, fs->GetPositionX()+3.0f*cos(a), fs->GetPositionY()+3.0f*sin(a), fs->GetPositionZ());
                                            fixingGUID = fs->GetGUID();
                                            return;
                                        }

                        Reset(); // all harpoons repaired
                        me->GetMotionMaster()->MoveTargetedHome();
                    }
                }
                else
                    timer -= diff;
            }
            else if (me->GetUInt32Value(UNIT_NPC_EMOTESTATE) == EMOTE_STATE_WORK)
                me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_STAND);
        }
    };
};

class go_ulduar_working_harpoon : public GameObjectScript
{
public:
    go_ulduar_working_harpoon() : GameObjectScript("go_ulduar_working_harpoon") { }

    bool OnGossipHello(Player* user, GameObject* go) override
    {
        if( !user || !go )
            return true;

        InstanceScript* pInstance = go->GetInstanceScript();
        if( !pInstance )
            return true;

        Creature* rs = nullptr;
        if( uint64 rsGUID = pInstance->GetData64(TYPE_RAZORSCALE) )
            rs = ObjectAccessor::GetCreature(*go, rsGUID);

        if( !rs || !rs->IsInCombat() )
        {
            go->SetRespawnTime(0);
            go->Delete();
            return true;
        }

        uint32 npc = 0;
        uint32 spell = 0;
        switch( go->GetEntry() )
        {
            case GO_HARPOON_GUN_1:
                npc = DATA_HARPOON_FIRE_STATE_1;
                spell = SPELL_CHAIN_1;
                break;
            case GO_HARPOON_GUN_2:
                npc = DATA_HARPOON_FIRE_STATE_2;
                spell = SPELL_CHAIN_2;
                break;
            case GO_HARPOON_GUN_3:
                npc = DATA_HARPOON_FIRE_STATE_3;
                spell = SPELL_CHAIN_3;
                break;
            case GO_HARPOON_GUN_4:
                npc = DATA_HARPOON_FIRE_STATE_4;
                spell = SPELL_CHAIN_4;
                break;
        }

        if( uint64 g = pInstance->GetData64(npc) )
            if( Creature* hfs = ObjectAccessor::GetCreature(*go, g) )
                hfs->AI()->SetData(3, spell);

        go->SetLootState(GO_JUST_DEACTIVATED);
        return true;
    }
};

class npc_ulduar_dark_rune_guardian : public CreatureScript
{
public:
    npc_ulduar_dark_rune_guardian() : CreatureScript("npc_ulduar_dark_rune_guardian") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_ulduar_dark_rune_guardianAI (pCreature);
    }

    struct npc_ulduar_dark_rune_guardianAI : public ScriptedAI
    {
        npc_ulduar_dark_rune_guardianAI(Creature *pCreature) : ScriptedAI(pCreature) { }

        uint32 timer2;

        void Reset()
        {
            timer2 = 6000;
        }

        bool CanAIAttack(const Unit* target) const
        {
            return target && target->GetEntry() != NPC_RAZORSCALE;
        }

        void UpdateAI(uint32 diff)
        {
            if( !UpdateVictim() )
                return;

            if (timer2 <= diff) timer2 = 0;
            else timer2 -= diff;
            if (timer2 == 0 && me->GetVictim() && me->IsWithinMeleeRange(me->GetVictim()))
            {
                me->CastSpell(me->GetVictim(), 65971, true);
                me->CastSpell(me->GetVictim(), 65971, true); // me->CastSpell(me->GetVictim(), 65972, true); // cast the same twice cus second one requires setting offhand damage
                me->CastSpell(me->GetVictim(), 64757, true);
                timer2 = urand(8000, 10000);
                return;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class npc_ulduar_dark_rune_watcher : public CreatureScript
{
public:
    npc_ulduar_dark_rune_watcher() : CreatureScript("npc_ulduar_dark_rune_watcher") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_ulduar_dark_rune_watcherAI (pCreature);
    }

    struct npc_ulduar_dark_rune_watcherAI : public ScriptedAI
    {
        npc_ulduar_dark_rune_watcherAI(Creature *pCreature) : ScriptedAI(pCreature) { }

        uint32 timer1;
        uint32 timer2;

        void Reset()
        {
            timer1 = 6000;
            timer2 = 2000;
        }

        bool CanAIAttack(const Unit* target) const
        {
            return target && target->GetEntry() != NPC_RAZORSCALE;
        }

        void UpdateAI(uint32 diff)
        {
            if( !UpdateVictim() )
                return;

            if( timer1 <= diff )
            {
                me->CastSpell(me->GetVictim(), RAID_MODE(64758, 64759), false);
                timer1 = urand(10000, 12000);
                return;
            }
            else
                timer1 -= diff;

            if (timer2 <= diff)
            {
                me->CastSpell(me->GetVictim(), RAID_MODE(63809, 64696), false);
                timer2 = 4000;
                return;
            }
            else
                timer2 -= diff;

            DoMeleeAttackIfReady();
        }
    };
};

class npc_ulduar_dark_rune_sentinel : public CreatureScript
{
public:
    npc_ulduar_dark_rune_sentinel() : CreatureScript("npc_ulduar_dark_rune_sentinel") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_ulduar_dark_rune_sentinelAI (pCreature);
    }

    struct npc_ulduar_dark_rune_sentinelAI : public ScriptedAI
    {
        npc_ulduar_dark_rune_sentinelAI(Creature *pCreature) : ScriptedAI(pCreature) { }

        uint32 timer1;
        uint32 timer2;

        void Reset()
        {
            timer1 = urand(1000,2000);
            timer2 = 6000;
        }

        bool CanAIAttack(const Unit* target) const
        {
            return target && target->GetEntry() != NPC_RAZORSCALE;
        }

        void UpdateAI(uint32 diff)
        {
            if( !UpdateVictim() )
                return;

            if( timer1 <= diff )
            {
                me->CastSpell(me, RAID_MODE(46763, 64062), false);
                timer1 = urand(15000, 20000);
            }
            else
                timer1 -= diff;

            if (timer2 <= diff) timer2 = 0;
            else timer2 -= diff;
            if (timer2 == 0 && me->GetVictim() && me->IsWithinMeleeRange(me->GetVictim()))
            {
                me->CastSpell(me, 63808, false);
                timer2 = urand(10000, 12000);
            }

            DoMeleeAttackIfReady();
        }
    };
};

class achievement_quick_shave : public AchievementCriteriaScript
{
    public:
        achievement_quick_shave() : AchievementCriteriaScript("achievement_quick_shave") {}

        bool OnCheck(Player*  /*player*/, Unit* target)
        {
            return target && target->GetTypeId() == TYPEID_UNIT && target->GetEntry() == NPC_RAZORSCALE && target->ToCreature()->AI()->GetData(1);
        }
};

class achievement_iron_dwarf_medium_rare : public AchievementCriteriaScript
{
    public:
        achievement_iron_dwarf_medium_rare() : AchievementCriteriaScript("achievement_iron_dwarf_medium_rare") {}

        bool OnCheck(Player*  /*player*/, Unit* target)
        {
            return target && target->GetEntry() == NPC_RAZORSCALE;
        }
};

void AddSC_boss_razorscale()
{
    new boss_razorscale();
    new npc_ulduar_expedition_commander();
    new npc_ulduar_harpoonfirestate();
    new npc_ulduar_expedition_engineer();
    new go_ulduar_working_harpoon();
    new npc_ulduar_dark_rune_guardian();
    new npc_ulduar_dark_rune_watcher();
    new npc_ulduar_dark_rune_sentinel();
    new achievement_quick_shave();
    new achievement_iron_dwarf_medium_rare();
}
