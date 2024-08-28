/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "AchievementCriteriaScript.h"
#include "CreatureScript.h"
#include "GameObjectScript.h"
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "SpellAuras.h"
#include "SpellScript.h"
#include "WaypointMgr.h"
#include "ulduar.h"

enum Spells
{
    // Razorscale
    SPELL_FLAMEBUFFET_10                    = 64016,
    SPELL_FLAMEBUFFET_25                    = 64023,
    SPELL_FIREBALL                          = 63815,
    SPELL_WINGBUFFET                        = 62666,
    SPELL_FLAMEBREATH_10                    = 63317,
    SPELL_FLAMEBREATH_25                    = 64021,
    SPELL_FUSEARMOR                         = 64771,
    SPELL_FUSED_ARMOR                       = 64774, // Applied on 5th stack of SPELL_FUSEARMOR
    SPELL_DEVOURINGFLAME                    = 63236,
    SPELL_BERSERK                           = 47008,

    // Haproons
    SPELL_CHAIN_1                           = 49679,
    SPELL_CHAIN_2                           = 49682,
    SPELL_CHAIN_3                           = 49683,
    SPELL_CHAIN_4                           = 49684,
    SPELL_LAUNCH_CHAIN                      = 62505,

    // Dark Rune Sentinel
    SPELL_WHIRLWIND                         = 63808,
    SPELL_BATTLE_SHOUT_10                   = 46763,
    SPELL_BATTLE_SHOUT_25                   = 64062,

    // Dark Rune Guardian
    SPELL_STORMSTRIKE_DMG                   = 65971,
    SPELL_STORMSTRIKE_DEBUFF                = 64757,

    // Dark Rune Watcher
    SPELL_LIGHTINGBOLT_10                   = 63809,
    SPELL_LIGHTINGBOLT_25                   = 64696,
    SPELL_CHAINLIGHTNING_10                 = 64758,
    SPELL_CHAINLIGHTNING_25                 = 64759,
};

#define SPELL_FLAMEBUFFET                   RAID_MODE(SPELL_FLAMEBUFFET_10, SPELL_FLAMEBUFFET_25)
#define SPELL_FLAMEBREATH                   RAID_MODE(SPELL_FLAMEBREATH_10, SPELL_FLAMEBREATH_25)
#define SPELL_BATTLE_SHOUT                  RAID_MODE(SPELL_BATTLE_SHOUT_10, SPELL_BATTLE_SHOUT_25)
#define SPELL_LIGHTINGBOLT                  RAID_MODE(SPELL_LIGHTINGBOLT_10, SPELL_LIGHTINGBOLT_25)
#define SPELL_CHAINLIGHTNING                RAID_MODE(SPELL_CHAINLIGHTNING_10, SPELL_CHAINLIGHTNING_25)
#define REQ_CHAIN_COUNT                     RAID_MODE(2, 4)

enum NPCs
{
    NPC_DARK_RUNE_SENTINEL                  = 33846,
    NPC_DARK_RUNE_GUARDIAN                  = 33388,
    NPC_DARK_RUNE_WATCHER                   = 33453,
    NPC_EXPEDITION_ENGINEER                 = 33287,
    NPC_EXPEDITION_COMMANDER                = 33210,
    NPC_RAZORSCALE_CONTROLLER               = 33233, // Trigger Creature
};

enum GOs
{
    GO_DRILL                                = 195305,
    GO_HARPOON_GUN_1                        = 194519,
    GO_HARPOON_GUN_2                        = 194541,
    GO_HARPOON_GUN_3                        = 194542,
    GO_HARPOON_GUN_4                        = 194543,
    GO_BROKEN_HARPOON                       = 194565,
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

enum Texts
{
    // Razorscale
    EMOTE_PERMA_GROUND                      = 0,
    EMOTE_BREATH                            = 1,
    EMOTE_BERSERK                           = 2,

    // Expedition Commander
    SAY_COMMANDER_AGGRO                     = 0,
    SAY_COMMANDER_GROUND_PHASE              = 1,
    SAY_COMMANDER_ENGINEERS_DEAD            = 2, // Should be called when all engineers are dead, currently unused

    // Expedition Engineer
    SAY_EE_AGGRO                            = 0,
    SAY_EE_START_REPAIR                     = 1,
    SAY_EE_REBUILD_TURRETS                  = 2,

    // Harpoon
    EMOTE_HARPOON                           = 0,
};

enum Misc
{
    POINT_RAZORSCALE_INIT                   = 1,
    REPAIR_POINTS                           = 25,

    // Expedition Commander Gossip
    GOSSIP_MENU_START_ENCOUNTER             = 10314,
    NPC_TEXT_COMMANDER                      = 40100,
};

const Position CORDS_GROUND                 = {588.0f, -166.0f, 391.1f};
const Position CORDS_AIR                    = {588.0f, -178.0f, 490.0f};

class boss_razorscale : public CreatureScript
{
public:
    boss_razorscale() : CreatureScript("boss_razorscale") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<boss_razorscaleAI>(pCreature);
    }

    struct boss_razorscaleAI : public ScriptedAI
    {
        boss_razorscaleAI(Creature* pCreature) : ScriptedAI(pCreature), summons(me)
        {
            pInstance = me->GetInstanceScript();
            startPath = true;
        }

        InstanceScript* pInstance;
        EventMap events;
        SummonList summons;
        ObjectGuid ExpeditionEngineerGUIDs[3];
        ObjectGuid CommanderGUID;
        float cords[4][2];
        bool bGroundPhase;
        bool startPath;
        uint8 flyTimes;

        void InitializeAI() override
        {
            me->SetDisableGravity(true);
            me->setActive(true);
            Reset();
        }

        void Reset() override
        {
            events.Reset();
            summons.DespawnAll();

            for (uint8 i = 0; i < 3; ++i)
                ExpeditionEngineerGUIDs[i].Clear();

            // Show gossip icon if previously hidden
            if (Creature* commander = ObjectAccessor::GetCreature(*me, CommanderGUID))
                if (!commander->HasNpcFlag(UNIT_NPC_FLAG_GOSSIP))
                    commander->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);

            CommanderGUID.Clear();
            bGroundPhase = false;
            flyTimes = 0;

            if( pInstance )
                pInstance->SetData(TYPE_RAZORSCALE, NOT_STARTED);
        }

        void AttackStart(Unit* who) override
        {
            if (who && me->Attack(who, true) && bGroundPhase)
                me->GetMotionMaster()->MoveChase(who);
        }

        void JustEngagedWith(Unit*  /*who*/) override
        {
            me->SetInCombatWithZone();
            events.Reset();
            events.ScheduleEvent(EVENT_COMMANDER_SAY_AGGRO, 5s);
            events.ScheduleEvent(EVENT_EE_SAY_MOVE_OUT, 10s);
            events.ScheduleEvent(EVENT_ENRAGE, 10min);
            events.ScheduleEvent(EVENT_SPELL_FIREBALL, 6s);
            events.ScheduleEvent(EVENT_SPELL_DEVOURING_FLAME, 13s);
            events.ScheduleEvent(EVENT_SUMMON_MOLE_MACHINES, 11s);

            std::list<Creature*> eeList;
            me->GetCreaturesWithEntryInRange(eeList, 300.0f, NPC_EXPEDITION_ENGINEER);
            uint8 i = 0;
            for( std::list<Creature*>::iterator itr = eeList.begin(); itr != eeList.end(); ++itr )
            {
                if( i > 2 )
                    break;
                ExpeditionEngineerGUIDs[i] = (*itr)->GetGUID();
                if (!i)
                    (*itr)->AI()->Talk(SAY_EE_AGGRO);
                ++i;
            }
            if (Creature* c = me->FindNearestCreature(NPC_EXPEDITION_COMMANDER, 300.0f, true))
                CommanderGUID = c->GetGUID();

            if( pInstance )
                pInstance->SetData(TYPE_RAZORSCALE, IN_PROGRESS);
        }

        void JustDied(Unit*  /*Killer*/) override
        {
            summons.DespawnAll();

            if( pInstance )
                pInstance->SetData(TYPE_RAZORSCALE, DONE);
        }

        void SpellHit(Unit* caster, SpellInfo const* spell) override
        {
            if (!caster || !pInstance)
                return;

            switch (spell->Id)
            {
                case SPELL_LAUNCH_CHAIN:
                    {
                        uint32 spellId = SPELL_CHAIN_4;

                        if (caster->GetGUID() == pInstance->GetGuidData(DATA_HARPOON_FIRE_STATE_1))
                        {
                            spellId = SPELL_CHAIN_1;
                        }
                        else if (caster->GetGUID() == pInstance->GetGuidData(DATA_HARPOON_FIRE_STATE_2))
                        {
                            spellId = SPELL_CHAIN_2;
                        }
                        else if (caster->GetGUID() == pInstance->GetGuidData(DATA_HARPOON_FIRE_STATE_3))
                        {
                            spellId = SPELL_CHAIN_3;
                        }

                        caster->CastSpell(me, spellId, true);
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
                        if (RAID_MODE(0, 1))
                        {
                            if( me->HasAura(SPELL_CHAIN_2) )
                                count++;
                            if( me->HasAura(SPELL_CHAIN_4) )
                                count++;
                        }
                        if( count >= REQ_CHAIN_COUNT )
                        {
                            if (Creature* commander = ObjectAccessor::GetCreature(*me, CommanderGUID))
                                commander->AI()->Talk(SAY_COMMANDER_GROUND_PHASE);

                            me->InterruptNonMeleeSpells(true);
                            events.CancelEvent(EVENT_SPELL_FIREBALL);
                            events.CancelEvent(EVENT_SPELL_DEVOURING_FLAME);
                            events.CancelEvent(EVENT_SUMMON_MOLE_MACHINES);
                            me->SetTarget();
                            me->SendMeleeAttackStop(me->GetVictim());
                            me->GetMotionMaster()->MoveLand(0, CORDS_GROUND, 25.0f);
                        }
                    }
                    break;
            }
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType /*damagetype*/, SpellSchoolMask /*damageSchoolMask*/) override
        {
            if (me->GetPositionZ() > 440.0f) // protection, razorscale is attackable (so harpoons can hit him, etc.), but should not receive dmg while in air
                damage = 0;
            else if (!bGroundPhase && ((me->GetHealth() * 100) / me->GetMaxHealth() < 50) && me->HasAura(62794)) // already below 50%, but still in chains and stunned
                events.RescheduleEvent(EVENT_WARN_DEEP_BREATH, 0ms);
        }

        void MovementInform(uint32 type, uint32 id) override
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
                me->SetOrientation((float)(M_PI + 0.01) / 2);
                me->SetFacingTo(M_PI / 2);
                me->SetDisableGravity(false);
                me->CastSpell(me, 62794, true);
                events.ScheduleEvent(EVENT_WARN_DEEP_BREATH, 30s);
            }
            else if (id == 1) // flied up
            {
                events.ScheduleEvent(EVENT_SPELL_FIREBALL, 2s);
                events.ScheduleEvent(EVENT_SPELL_DEVOURING_FLAME, 4s);
                events.ScheduleEvent(EVENT_SUMMON_MOLE_MACHINES, 5s);
            }
        }

        void UpdateAI(uint32 diff) override
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

            switch (events.ExecuteEvent())
            {
                case 0:
                    break;
                case EVENT_ENRAGE:
                    Talk(EMOTE_BERSERK);
                    me->CastSpell(me, SPELL_BERSERK, true);
                    break;
                case EVENT_COMMANDER_SAY_AGGRO:
                    if (Creature* commander = ObjectAccessor::GetCreature(*me, CommanderGUID))
                        commander->AI()->Talk(SAY_COMMANDER_AGGRO);
                    break;
                case EVENT_EE_SAY_MOVE_OUT:
                    for (uint8 i = 0; i < 3; ++i)
                        if (Creature* c = ObjectAccessor::GetCreature(*me, ExpeditionEngineerGUIDs[i]))
                        {
                            if (!i)
                                c->AI()->Talk(SAY_EE_START_REPAIR);
                            c->AI()->SetData(1, 0); // start repairing
                        }
                    break;
                case EVENT_SPELL_FIREBALL:
                    if( Unit* pTarget = SelectTarget(SelectTargetMethod::Random, 0, 200.0f, true) )
                        me->CastSpell(pTarget, SPELL_FIREBALL, false);
                    events.Repeat(4s);
                    break;
                case EVENT_SPELL_DEVOURING_FLAME:
                    if( Unit* pTarget = SelectTarget(SelectTargetMethod::Random, 0, 200.0f, true) )
                        me->CastSpell(pTarget, SPELL_DEVOURINGFLAME, false);
                    events.Repeat(13s);
                    break;
                case EVENT_SUMMON_MOLE_MACHINES:
                    {
                        memset(cords, '\0', sizeof(cords));
                        uint8 num = RAID_MODE( urand(2, 3), urand(2, 4) );
                        for( int i = 0; i < num; ++i )
                        {
                            // X: (550, 625) Y: (-185, -230)
                            cords[i][0] = urand(550, 625);
                            cords[i][1] = -230 + rand() % 45;
                            if( GameObject* drill = me->SummonGameObject(GO_DRILL, cords[i][0], cords[i][1], 391.1f, M_PI / 4, 0.0f, 0.0f, 0.0f, 0.0f, 8) )
                            {
                                //drill->SetGoAnimProgress(0);
                                //drill->SetLootState(GO_READY);
                                //drill->UseDoorOrButton(8);
                                //drill->SetGoState(GO_STATE_READY);
                                drill->SetGoState(GO_STATE_ACTIVE);
                                drill->SetGoAnimProgress(0);
                            }
                        }
                        events.Repeat(45s);
                        events.RescheduleEvent(EVENT_SUMMON_ADDS, 4s);
                    }
                    break;
                case EVENT_SUMMON_ADDS:
                    for( int i = 0; i < 4; ++i )
                    {
                        if( !cords[i][0] )
                            break;

                        uint8 opt;
                        uint8 r = urand(1, 100);
                        if( r <= 30 ) opt = 1;
                        else if( r <= 65 ) opt = 2;
                        else opt = 3;

                        for( int j = 0; j < 4; ++j )
                        {
                            float x = cords[i][0] + 4.0f * cos(j * M_PI / 2);
                            float y = cords[i][1] + 4.0f * std::sin(j * M_PI / 2);

                            uint32 npc_entry = 0;
                            switch( opt )
                            {
                                case 1:
                                    if( j == 1 ) npc_entry = NPC_DARK_RUNE_SENTINEL;
                                    break;
                                case 2:
                                    switch( j )
                                    {
                                        case 1:
                                            npc_entry = NPC_DARK_RUNE_WATCHER;
                                            break;
                                        case 2:
                                            npc_entry = NPC_DARK_RUNE_GUARDIAN;
                                            break;
                                    }
                                    break;
                                default: // case 3:
                                    switch( j )
                                    {
                                        case 1:
                                            npc_entry = NPC_DARK_RUNE_WATCHER;
                                            break;
                                        case 2:
                                            npc_entry = NPC_DARK_RUNE_GUARDIAN;
                                            break;
                                        case 3:
                                            npc_entry = NPC_DARK_RUNE_GUARDIAN;
                                            break;
                                    }
                                    break;
                            }

                            if( npc_entry )
                                if (Creature* c = me->SummonCreature(npc_entry, x, y, 391.1f, j * M_PI / 2, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000))
                                    DoZoneInCombat(c);
                        }
                    }
                    break;
                case EVENT_WARN_DEEP_BREATH:
                    Talk(EMOTE_BREATH);
                    me->RemoveAura(62794);
                    events.ScheduleEvent(EVENT_PHASE2_FLAME_BREATH, 2500ms);
                    break;
                case EVENT_PHASE2_FLAME_BREATH:
                    me->CastSpell(me, SPELL_FLAMEBREATH, true);
                    events.ScheduleEvent(EVENT_FLY_UP, 2s);
                    break;
                case EVENT_FLY_UP:
                    me->SetInCombatWithZone(); // just in case
                    if (pInstance)
                        for( int i = 0; i < 4; ++i )
                            if( ObjectGuid guid = pInstance->GetGuidData(DATA_HARPOON_FIRE_STATE_1 + i) )
                                if( Creature* hfs = ObjectAccessor::GetCreature(*me, guid) )
                                {
                                    me->SummonCreature(34188, hfs->GetPositionX(), hfs->GetPositionY(), hfs->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN, 22000);
                                    hfs->AI()->SetData(1, 0);
                                }

                    me->RemoveAura(SPELL_LAUNCH_CHAIN);
                    me->RemoveAura(SPELL_CHAIN_1);
                    me->RemoveAura(SPELL_CHAIN_3);
                    if (RAID_MODE(0, 1))
                    {
                        me->RemoveAura(SPELL_CHAIN_2);
                        me->RemoveAura(SPELL_CHAIN_4);
                    }
                    me->CastSpell(me, SPELL_WINGBUFFET, true);

                    if( (me->GetHealth() * 100) / me->GetMaxHealth() < 50 ) // start phase 3
                    {
                        Talk(EMOTE_PERMA_GROUND);
                        me->SetControlled(false, UNIT_STATE_ROOT);
                        me->DisableRotate(false);
                        DoResetThreatList();
                        Unit* target = SelectTarget(SelectTargetMethod::MaxDistance, 0, 0.0, true);
                        if (!target)
                            target = me->SelectNearestPlayer(200.0f);
                        if (target)
                        {
                            AttackStart(target);
                            me->GetMotionMaster()->MoveChase(target);
                        }
                        bGroundPhase = true;
                        events.CancelEvent(EVENT_SPELL_FIREBALL);
                        events.CancelEvent(EVENT_SPELL_DEVOURING_FLAME);
                        events.CancelEvent(EVENT_SUMMON_MOLE_MACHINES);

                        events.ScheduleEvent(EVENT_SPELL_FLAME_BREATH, 20s);
                        events.ScheduleEvent(EVENT_SPELL_DEVOURING_FLAME_GROUND, 5s);
                        events.ScheduleEvent(EVENT_SPELL_FUSE_ARMOR, 10s);
                        events.ScheduleEvent(EVENT_SPELL_FLAME_BUFFET, 3s);

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
                        me->SetDisableGravity(true);
                        me->GetMotionMaster()->MoveTakeoff(1, CORDS_AIR, 25.0f);
                        events.ScheduleEvent(EVENT_RESUME_FIXING, 22s);
                    }

                    break;
                case EVENT_RESUME_FIXING:
                    for (uint8 i = 0; i < 3; ++i)
                        if (Creature* c = ObjectAccessor::GetCreature(*me, ExpeditionEngineerGUIDs[i]))
                        {
                            if (!i)
                                c->AI()->Talk(SAY_EE_REBUILD_TURRETS);
                            c->AI()->SetData(1, 0); // start repairing
                        }
                    break;
                case EVENT_SPELL_FLAME_BREATH:
                    me->CastSpell(me->GetVictim(), SPELL_FLAMEBREATH, false);
                    events.Repeat(20s);
                    break;
                case EVENT_SPELL_DEVOURING_FLAME_GROUND:
                    me->CastSpell(me->GetVictim(), SPELL_DEVOURINGFLAME, false);
                    events.Repeat(13s);
                    break;
                case EVENT_SPELL_FUSE_ARMOR:
                    if (Unit* victim = me->GetVictim())
                        if (me->IsWithinMeleeRange(victim))
                        {
                            me->CastSpell(victim, SPELL_FUSEARMOR, false);
                            if (Aura* aur = victim->GetAura(SPELL_FUSEARMOR))
                                if (aur->GetStackAmount() == 5)
                                    victim->CastSpell(victim, SPELL_FUSED_ARMOR, true);
                            events.Repeat(10s);
                            break;
                        }
                    events.Repeat(2s);
                    break;
                case EVENT_SPELL_FLAME_BUFFET:
                    me->CastSpell(me->GetVictim(), SPELL_FLAMEBUFFET, false);
                    events.Repeat(7s);
                    break;
            }

            if (bGroundPhase)
                DoMeleeAttackIfReady();
        }

        void MoveInLineOfSight(Unit* /*who*/) override {}

        void JustReachedHome() override
        {
            startPath = true;
        }

        void JustSummoned(Creature* s) override
        {
            summons.Summon(s);
        }

        uint32 GetData(uint32 id) const override
        {
            if (id == 1)
                return (flyTimes <= 1 ? 1 : 0);
            return 0;
        }

        void KilledUnit(Unit* victim) override
        {
            if (victim && victim->GetEntry() == NPC_DARK_RUNE_GUARDIAN)
                if (pInstance)
                    pInstance->DoUpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_KILL_CREATURE, NPC_DARK_RUNE_GUARDIAN, 1, me);
        }

        void EnterEvadeMode(EvadeReason why) override
        {
            me->SetDisableGravity(true);
            me->SetControlled(false, UNIT_STATE_ROOT);
            me->DisableRotate(false);
            ScriptedAI::EnterEvadeMode(why);
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

        Creature* razorscale = ObjectAccessor::GetCreature(*creature, instance->GetGuidData(TYPE_RAZORSCALE));
        if (!razorscale || razorscale->IsInCombat())
            return true;

        AddGossipItemFor(player, GOSSIP_MENU_START_ENCOUNTER, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        SendGossipMenuFor(player, NPC_TEXT_COMMANDER, creature);
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32  /*uiSender*/, uint32 uiAction) override
    {
        if (!player || !creature)
            return true;

        if (uiAction == GOSSIP_ACTION_INFO_DEF + 1)
        {
            InstanceScript* instance = creature->GetInstanceScript();
            if (!instance || instance->GetData(TYPE_RAZORSCALE) == DONE)
                return true;

            Creature* razorscale = ObjectAccessor::GetCreature(*creature, instance->GetGuidData(TYPE_RAZORSCALE));
            if (razorscale && !razorscale->IsInCombat())
            {
                // Do not show gossip icon if encounter is in progress
                creature->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);

                // reset npcs NPC_HARPOON_FIRE_STATE
                for (uint8 i = 0; i < 4; ++i)
                    if (Creature* hfs = ObjectAccessor::GetCreature(*creature, instance->GetGuidData(DATA_HARPOON_FIRE_STATE_1 + i)))
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
        return GetUlduarAI<npc_ulduar_expedition_commanderAI>(creature);
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
           //Talk(SAY_COMMANDER_INTRO); // No source leads to showing any text messages, perhaps only SOUND ID 15647 is played?
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

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<npc_ulduar_harpoonfirestateAI>(pCreature);
    }

    struct npc_ulduar_harpoonfirestateAI : public NullCreatureAI
    {
        npc_ulduar_harpoonfirestateAI(Creature* pCreature) : NullCreatureAI(pCreature)
        {
            pInstance = me->GetInstanceScript();
        }

        InstanceScript* pInstance;
        uint8 repairPoints;

        void Reset() override
        {
            repairPoints = 0;
        }

        uint32 GetHarpoonGunIdForThisHFS()
        {
            if (pInstance)
            {
                if( me->GetGUID() == pInstance->GetGuidData(DATA_HARPOON_FIRE_STATE_1) )
                    return GO_HARPOON_GUN_1;
                else if( me->GetGUID() == pInstance->GetGuidData(DATA_HARPOON_FIRE_STATE_2) )
                    return GO_HARPOON_GUN_2;
                else if( me->GetGUID() == pInstance->GetGuidData(DATA_HARPOON_FIRE_STATE_3) )
                    return GO_HARPOON_GUN_3;
                else
                    return GO_HARPOON_GUN_4;
            }
            return 0;
        }

        void SetData(uint32 id, uint32 value) override
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
                            if( GameObject* wh = me->SummonGameObject(GetHarpoonGunIdForThisHFS(), me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 3 * M_PI / 2, 0.0f, 0.0f, 0.0f, 0.0f, 0) )
                            {
                                me->RemoveGameObject(wh, false);
                                if (Creature* cr = me->SummonCreature(NPC_RAZORSCALE_CONTROLLER, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN, 5000))
                                    cr->AI()->Talk(EMOTE_HARPOON);
                            }
                        }
                    }
                    break;
                case 3: // shoot
                    if (pInstance)
                    {
                        Creature* razorscale = ObjectAccessor::GetCreature(*me, pInstance->GetGuidData(TYPE_RAZORSCALE));
                        if (!razorscale)
                            return;
                        if (!razorscale->HasAura(value))
                            me->CastSpell(razorscale, SPELL_LAUNCH_CHAIN, true);
                    }
                    break;
            }
        }

        uint32 GetData(uint32 id) const override
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

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<npc_ulduar_expedition_engineerAI>(pCreature);
    }

    struct npc_ulduar_expedition_engineerAI : public NullCreatureAI
    {
        npc_ulduar_expedition_engineerAI(Creature* pCreature) : NullCreatureAI(pCreature)
        {
            pInstance = me->GetInstanceScript();
        }

        InstanceScript* pInstance;
        bool working;
        uint16 timer;
        ObjectGuid fixingGUID;

        void Reset() override
        {
            working = false;
            timer = 0;
            fixingGUID.Clear();
        }

        void SetData(uint32 id, uint32  /*value*/) override
        {
            switch (id)
            {
                case 1: // start/resume repairing
                    working = true;
                    timer = 0;
                    fixingGUID.Clear();
                    break;
                case 2: // stop repairing
                    Reset();
                    me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_STAND);
                    me->GetMotionMaster()->MoveTargetedHome();
                    break;
            }
        }

        void UpdateAI(uint32 diff) override
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

                                if (std::fabs(me->GetOrientation() - me->GetAngle(c)) > M_PI / 4)
                                    me->SetFacingToObject(c);

                                c->AI()->SetData(2, 0);
                                if (c->AI()->GetData(2))
                                    fixingGUID.Clear();
                            }
                    }

                    if (!fixingGUID)
                    {
                        Creature* razorscale = nullptr;
                        if( ObjectGuid rsGUID = pInstance->GetGuidData(TYPE_RAZORSCALE) )
                            razorscale = ObjectAccessor::GetCreature(*me, rsGUID);

                        if( !razorscale || !razorscale->IsInCombat() )
                        {
                            Reset();
                            me->GetMotionMaster()->MoveTargetedHome();
                            return;
                        }

                        for( int i = 0; i < 4; ++i )
                            if( ObjectGuid fs_GUID = pInstance->GetGuidData(DATA_HARPOON_FIRE_STATE_1 + i) )
                                if( Creature* fs = ObjectAccessor::GetCreature(*me, fs_GUID) )
                                    if (!fs->AI()->GetData(2))
                                    {
                                        float a = rand_norm() * M_PI;
                                        me->GetMotionMaster()->MovePoint(0, fs->GetPositionX() + 3.0f * cos(a), fs->GetPositionY() + 3.0f * std::sin(a), fs->GetPositionZ());
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
        if( ObjectGuid rsGUID = pInstance->GetGuidData(TYPE_RAZORSCALE) )
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

        if( ObjectGuid g = pInstance->GetGuidData(npc) )
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

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<npc_ulduar_dark_rune_guardianAI>(pCreature);
    }

    struct npc_ulduar_dark_rune_guardianAI : public ScriptedAI
    {
        npc_ulduar_dark_rune_guardianAI(Creature* pCreature) : ScriptedAI(pCreature) { }

        uint32 timer2;

        void Reset() override
        {
            timer2 = 6000;
        }

        bool CanAIAttack(Unit const* target) const override
        {
            return target && target->GetEntry() != NPC_RAZORSCALE;
        }

        void UpdateAI(uint32 diff) override
        {
            if( !UpdateVictim() )
                return;

            if (timer2 <= diff) timer2 = 0;
            else timer2 -= diff;
            if (timer2 == 0 && me->GetVictim() && me->IsWithinMeleeRange(me->GetVictim()))
            {
                me->CastSpell(me->GetVictim(), SPELL_STORMSTRIKE_DMG, true);
                me->CastSpell(me->GetVictim(), SPELL_STORMSTRIKE_DMG, true); // cast the same twice cus second one requires setting offhand damage
                me->CastSpell(me->GetVictim(), SPELL_STORMSTRIKE_DEBUFF, true);
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

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<npc_ulduar_dark_rune_watcherAI>(pCreature);
    }

    struct npc_ulduar_dark_rune_watcherAI : public ScriptedAI
    {
        npc_ulduar_dark_rune_watcherAI(Creature* pCreature) : ScriptedAI(pCreature) { }

        uint32 timer1;
        uint32 timer2;

        void Reset() override
        {
            timer1 = 6000;
            timer2 = 2000;
        }

        bool CanAIAttack(Unit const* target) const override
        {
            return target && target->GetEntry() != NPC_RAZORSCALE;
        }

        void UpdateAI(uint32 diff) override
        {
            if( !UpdateVictim() )
                return;

            if( timer1 <= diff )
            {
                me->CastSpell(me->GetVictim(), SPELL_CHAINLIGHTNING, false);
                timer1 = urand(10000, 12000);
                return;
            }
            else
                timer1 -= diff;

            if (timer2 <= diff)
            {
                me->CastSpell(me->GetVictim(), SPELL_LIGHTINGBOLT, false);
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

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<npc_ulduar_dark_rune_sentinelAI>(pCreature);
    }

    struct npc_ulduar_dark_rune_sentinelAI : public ScriptedAI
    {
        npc_ulduar_dark_rune_sentinelAI(Creature* pCreature) : ScriptedAI(pCreature) { }

        uint32 timer1;
        uint32 timer2;

        void Reset() override
        {
            timer1 = urand(1000, 2000);
            timer2 = 6000;
        }

        bool CanAIAttack(Unit const* target) const override
        {
            return target && target->GetEntry() != NPC_RAZORSCALE;
        }

        void UpdateAI(uint32 diff) override
        {
            if( !UpdateVictim() )
                return;

            if( timer1 <= diff )
            {
                me->CastSpell(me, SPELL_BATTLE_SHOUT, false);
                timer1 = urand(15000, 20000);
            }
            else
                timer1 -= diff;

            if (timer2 <= diff) timer2 = 0;
            else timer2 -= diff;
            if (timer2 == 0 && me->GetVictim() && me->IsWithinMeleeRange(me->GetVictim()))
            {
                me->CastSpell(me, SPELL_WHIRLWIND, false);
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

    bool OnCheck(Player*  /*player*/, Unit* target, uint32 /*criteria_id*/) override
    {
        return target && target->GetTypeId() == TYPEID_UNIT && target->GetEntry() == NPC_RAZORSCALE && target->ToCreature()->AI()->GetData(1);
    }
};

class achievement_iron_dwarf_medium_rare : public AchievementCriteriaScript
{
public:
    achievement_iron_dwarf_medium_rare() : AchievementCriteriaScript("achievement_iron_dwarf_medium_rare") {}

    bool OnCheck(Player*  /*player*/, Unit* target, uint32 /*criteria_id*/) override
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
