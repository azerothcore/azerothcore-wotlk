/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "obsidian_sanctum.h"
#include "SpellScript.h"
#include "SpellAuras.h"

enum Says
{
    // SARTHARION
    SAY_SARTHARION_AGGRO                        = 0,
    SAY_SARTHARION_BERSERK                      = 1,
    SAY_SARTHARION_BREATH                       = 2,
    SAY_SARTHARION_CALL_SHADRON                 = 3,
    SAY_SARTHARION_CALL_TENEBRON                = 4,
    SAY_SARTHARION_CALL_VESPERON                = 5,
    SAY_SARTHARION_DEATH                        = 6,
    SAY_SARTHARION_SPECIAL                      = 7,
    SAY_SARTHARION_SLAY                         = 8,
    SAY_SARTHARION_SPECIAL_4                    = 10, // 9 is whisper

    // TENEBRON
    SAY_TENEBRON_AGGRO                          = 0,
    SAY_TENEBRON_SLAY                           = 1,
    SAY_TENEBRON_DEATH                          = 2,
    SAY_TENEBRON_BREATH                         = 3,
    SAY_TENEBRON_RESPOND                        = 4,
    SAY_TENEBRON_SPECIAL                        = 5,

    // SHADRON
    SAY_SHADRON_AGGRO                           = 0,
    SAY_SHADRON_SLAY                            = 1,
    SAY_SHADRON_DEATH                           = 2,
    SAY_SHADRON_BREATH                          = 3,
    SAY_SHADRON_RESPOND                         = 4,
    SAY_SHADRON_SPECIAL                         = 5,

    // VESPERON
    SAY_VESPERON_AGGRO                          = 0,
    SAY_VESPERON_SLAY                           = 1,
    SAY_VESPERON_DEATH                          = 2,
    SAY_VESPERON_BREATH                         = 3,
    SAY_VESPERON_RESPOND                        = 4,
    SAY_VESPERON_SPECIAL                        = 5,

    // MISC
    WHISPER_LAVA_CHURN                          = 9,
    WHISPER_OPEN_PORTAL                         = 6,
    WHISPER_HATCH_EGGS                          = 6,
    WHISPER_SUMMON_DICIPLE                      = 7,
};

// Uses spelldifficulty_dbc
enum Spells
{
    // Mini-boss shared
    SPELL_SHADOW_BREATH                         = 57570,
    SPELL_SHADOW_FISSURE                        = 57579,
    SPELL_SUMMON_TWILIGHT_WHELP                 = 58035,
    SPELL_GIFT_OF_TWILIGHT_SHADOW               = 57835,
    SPELL_TWILIGHT_TORMENT_VESPERON             = 57935,

    // Sartharion
    SPELL_SARTHARION_CLEAVE                     = 56909,
    SPELL_SARTHARION_FLAME_BREATH               = 56908,
    SPELL_SARTHARION_TAIL_LASH                  = 56910,
    SPELL_CYCLONE_AURA_PERIODIC                 = 57598,
    SPELL_LAVA_STRIKE_DUMMY_TRIGGER             = 57697,
    SPELL_LAVA_STRIKE_SUMMON                    = 57572,
    SPELL_SARTHARION_PYROBUFFET                 = 56916,
    SPELL_SARTHARION_BERSERK                    = 61632,
    SPELL_SARTHARION_TWILIGHT_REVENGE           = 60639,
    
    // Sartharion with drakes
    SPELL_WILL_OF_SARTHARION                    = 61254,
    SPELL_POWER_OF_TENEBRON                     = 61248,
    SPELL_POWER_OF_VESPERON                     = 61251,
    SPELL_POWER_OF_SHADRON                      = 58105,
    SPELL_GIFT_OF_TWILIGHT_FIRE                 = 58766,

    // Visuals
    SPELL_EGG_MARKER_VISUAL                     = 58547,
    SPELL_FLAME_TSUNAMI_VISUAL                  = 57494,

    // Misc
    SPELL_FADE_ARMOR                            = 60708,
    SPELL_FLAME_TSUNAMI_DAMAGE_AURA             = 57492,
    SPELL_SARTHARION_PYROBUFFET_TRIGGER         = 57557,
};

enum NPCs
{
    NPC_TWILIGHT_EGG                            = 30882,
    NPC_TWILIGHT_WHELP                          = 30890,
    NPC_DISCIPLE_OF_SHADRON                     = 30688,
    NPC_DISCIPLE_OF_VESPERON                    = 30858,
    NPC_ACOLYTE_OF_SHADRON                      = 31218,
    NPC_ACOLYTE_OF_VESPERON                     = 31219,

    // Sartharion fight
    NPC_LAVA_BLAZE                              = 30643,
    NPC_FLAME_TSUNAMI                           = 30616,
    NPC_SAFE_AREA_TRIGGER                       = 30494,
};

enum Misc
{
    ACTION_SWITCH_PHASE                         = 1,
    ACTION_CALL_DRAGON                          = 2,
    ACTION_DRAKE_DIED                           = 3,

    DRAGON_TENEBRON                             = 0,
    DRAGON_SHADRON                              = 1,
    DRAGON_VESPERON                             = 2,

    POINT_FINAL_TENEBRON                        = 8,
    POINT_FINAL_SHADRON                         = 4,
    POINT_FINAL_VESPERON                        = 4,
};

enum Events
{
    // Solo drake abilities
    EVENT_MINIBOSS_SHADOW_FISSURE               = 1,
    EVENT_MINIBOSS_SHADOW_BREATH                = 2,
    EVENT_MINIBOSS_HATCH_EGGS                   = 3,
    EVENT_MINIBOSS_OPEN_PORTAL                  = 4,
    EVENT_MINIBOSS_SPAWN_HELPERS                = 5,
    EVENT_MINIBOSS_RESPOND                      = 6,

    // Sartharion abilities
    EVENT_SARTHARION_CAST_CLEAVE                = 10,
    EVENT_SARTHARION_CAST_FLAME_BREATH          = 11,
    EVENT_SARTHARION_CAST_TAIL_LASH             = 12,
    EVENT_SARTHARION_SUMMON_LAVA                = 13,
    EVENT_SARTHARION_START_LAVA                 = 14,
    EVENT_SARTHARION_FINISH_LAVA                = 15,
    EVENT_SARTHARION_LAVA_STRIKE                = 16,
    EVENT_SARTHARION_HEALTH_CHECK               = 17,
    EVENT_SARTHARION_BERSERK                    = 18,
    
    // Drake abilities called by sartharion
    EVENT_SARTHARION_CALL_TENEBRON              = 30,
    EVENT_SARTHARION_CALL_SHADRON               = 31,
    EVENT_SARTHARION_CALL_VESPERON              = 32,

    EVENT_SARTHARION_BOUNDARY                   = 33
};

const Position portalPos[4] = 
{
    {3247.29f, 529.804f, 58.9595f, 0.0f},
    {3248.62f, 646.739f, 85.2939f, 0.0f},
    {3151.20f, 517.862f, 90.3389f, 0.0f},
    {3351.78f, 517.138f, 99.1620f, 0.0f},
};

const Position EggsPos[12] = 
{
    // Tenebron
    {3253.09f, 657.439f, 86.9921f, 3.16334f},
    {3247.76f, 662.413f, 87.7281f, 4.12938f},
    {3246.01f, 656.606f, 86.8737f, 4.12938f},
    {3246.7f, 649.558f, 85.8179f, 4.12938f},
    {3238.72f, 650.386f, 85.9625f, 0.897469f}, 
    {3257.89f, 651.323f, 85.9177f, 0.897469f},
    // Sartharion
    {3237.24f, 524.20f, 58.95f, 0.0f},
    {3238.95f, 513.96f, 58.662f, 0.7f},
    {3245.66f, 519.685f, 58.78f, 0.7f},
    {3254.64f, 524.6f, 58.811f, 1.966f},
    {3258.9f, 534.41f, 58.811f, 2.08f},
    {3248.23f, 541.93f, 58.718f, 3.29f}
};

/////////////////////////////
// SARTHARION
/////////////////////////////

class boss_sartharion : public CreatureScript
{
public:
    boss_sartharion() : CreatureScript("boss_sartharion") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_sartharionAI (pCreature);
    }

    struct boss_sartharionAI : public ScriptedAI
    {
        boss_sartharionAI(Creature* pCreature) : ScriptedAI(pCreature), summons(me)
        {
            pInstance = me->GetInstanceScript();
            dragons[0] = dragons[1] = dragons[2] = 0;
        }

        InstanceScript* pInstance;
        SummonList summons;
        EventMap events;
        uint64 dragons[3];
        uint8 dragonsCount;
        bool usedBerserk;
        std::list<uint32> volcanoBlows;

        void HandleSartharionAbilities();
        void HandleDrakeAbilities();

        void SummonStartingTriggers()
        {
            me->SummonCreature(NPC_FIRE_CYCLONE, 3235.28f, 591.180f, 57.0833f, 0.59037f);
            me->SummonCreature(NPC_FIRE_CYCLONE, 3200.97f, 480.929f, 57.0833f, 5.86197f);
            me->SummonCreature(NPC_FIRE_CYCLONE, 3281.57f, 507.984f, 57.0833f, 5.54346f);
            me->SummonCreature(NPC_FIRE_CYCLONE, 3210.11f, 531.957f, 57.0833f, 3.76777f);
            me->SummonCreature(NPC_FIRE_CYCLONE, 3286.42f, 585.010f, 57.0833f, 4.10307f);
            
            me->SummonCreature(NPC_SAFE_AREA_TRIGGER, 3244.14f, 512.597f, 58.6534f, 0.0f);
            me->SummonCreature(NPC_SAFE_AREA_TRIGGER, 3242.84f, 553.979f, 58.8272f, 0.0f);
        }

        void SummonLavaWaves()
        {
            summons.RemoveNotExisting();
            Talk(WHISPER_LAVA_CHURN);
            events.ScheduleEvent(EVENT_SARTHARION_START_LAVA, 2000);
            events.ScheduleEvent(EVENT_SARTHARION_FINISH_LAVA, 9000);

            // Send wave from left
            if (urand(0,1))
            {
                for (uint8 i = 0; i < 3; ++i)
                    me->SummonCreature(NPC_FLAME_TSUNAMI, 3208.44f, 580.0f-(i*50.0f), 55.8f, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 12000);
            }
            // from right
            else
            {
                for (uint8 i = 0; i < 2; ++i)
                    me->SummonCreature(NPC_FLAME_TSUNAMI, 3283.44f, 555.0f-(i*50.0f), 55.8f, 3.14f, TEMPSUMMON_TIMED_DESPAWN, 12000);
            }
        }

        void SendLavaWaves(bool start)
        {
            Unit* cr = nullptr;
            for (SummonList::const_iterator itr = summons.begin(); itr != summons.end(); ++itr)
            {
                cr = ObjectAccessor::GetUnit(*me, *itr);
                if (!cr || cr->GetEntry() != NPC_FLAME_TSUNAMI)
                    continue;

                if (start)
                    cr->GetMotionMaster()->MovePoint(0, ((cr->GetPositionX() < 3250.0f) ? 3283.44f : 3208.44f), cr->GetPositionY(), cr->GetPositionZ());
                else
                    cr->SetObjectScale(0.1f);
            }
        }

        void StoreDragons()
        {
            if (pInstance)
            {
                Unit* cr = nullptr;
                for (uint8 i = 0; i < 3; ++i)
                    if ((cr = ObjectAccessor::GetUnit(*me, pInstance->GetData64(DATA_TENEBRON+i))))
                    {
                        if (!cr->IsAlive())
                            continue;

                        cr->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_NPC);
                        dragons[i] = cr->GetGUID();
                        dragonsCount++;
                        me->AddLootMode(1 << dragonsCount);

                        cr->SetHealth(cr->GetMaxHealth());
                        switch(DATA_TENEBRON+i)
                        {
                            case DATA_TENEBRON:
                                cr->CastSpell(cr, SPELL_POWER_OF_TENEBRON, true);
                                events.ScheduleEvent(EVENT_SARTHARION_CALL_TENEBRON, 10000);
                                break;
                            case DATA_SHADRON:
                                cr->CastSpell(cr, SPELL_POWER_OF_SHADRON, true);
                                events.ScheduleEvent(EVENT_SARTHARION_CALL_SHADRON, 65000);
                                break;
                            case DATA_VESPERON:
                                cr->CastSpell(cr, SPELL_POWER_OF_VESPERON, true);
                                events.ScheduleEvent(EVENT_SARTHARION_CALL_VESPERON, 115000);
                                break;
                        }
                    }

                if (dragonsCount)
                    me->CastSpell(me, SPELL_WILL_OF_SARTHARION, true);
            }
        }

        void RespawnDragons(bool combat)
        {
            if (pInstance)
            {
                Creature* cr = nullptr;
                for (uint8 i = 0; i < 3; ++i)
                    if (dragons[i])
                        if ((cr = ObjectAccessor::GetCreature(*me, dragons[i])))
                        {
                            if (combat && cr->IsInCombat())
                                continue;

                            cr->DespawnOrUnsummon();
                            cr->SetRespawnTime(10);
                        }

                dragons[0] = dragons[1] = dragons[2] = 0;
                dragonsCount = 0;
            }
        }

        void Reset()
        {
            events.Reset();
            summons.DespawnAll();
            me->ResetLootMode();
            RespawnDragons(false);
            SummonStartingTriggers();
            usedBerserk = false;
            volcanoBlows.clear();

            if (pInstance)
            {
                pInstance->SetData(BOSS_SARTHARION_EVENT, NOT_STARTED);
                pInstance->DoRemoveAurasDueToSpellOnPlayers(SPELL_TWILIGHT_SHIFT);
            }
        }

        void DoAction(int32 param)
        {
            if (param == ACTION_DRAKE_DIED)
                me->CastSpell(me, SPELL_SARTHARION_TWILIGHT_REVENGE, true);
        }

        void EnterCombat(Unit*  /*pWho*/)
        {
            me->CastSpell(me, SPELL_SARTHARION_PYROBUFFET, true);
            me->SetInCombatWithZone();
            Talk(SAY_SARTHARION_AGGRO);
            if (pInstance)
                pInstance->SetData(BOSS_SARTHARION_EVENT, IN_PROGRESS);

            events.ScheduleEvent(EVENT_SARTHARION_CAST_CLEAVE, 7000);
            events.ScheduleEvent(EVENT_SARTHARION_CAST_FLAME_BREATH, 15000);
            events.ScheduleEvent(EVENT_SARTHARION_CAST_TAIL_LASH, 11000);
            events.ScheduleEvent(EVENT_SARTHARION_SUMMON_LAVA, 20000);
            events.ScheduleEvent(EVENT_SARTHARION_LAVA_STRIKE, 5000);
            events.ScheduleEvent(EVENT_SARTHARION_HEALTH_CHECK, 10000);
            events.ScheduleEvent(EVENT_SARTHARION_BERSERK, 900000);
            events.ScheduleEvent(EVENT_SARTHARION_BOUNDARY, 1000);

            StoreDragons();
            me->CallForHelp(500.0f);
        }

        void JustDied(Unit*  /*pKiller*/)
        {
            RespawnDragons(true);
            summons.DespawnAll();
            Talk(SAY_SARTHARION_DEATH);

            if (pInstance)
                pInstance->SetData(BOSS_SARTHARION_EVENT, DONE);
        }

        void KilledUnit(Unit* pVictim)
        {
            if (!urand(0, 2) && pVictim->GetTypeId() == TYPEID_PLAYER)
                Talk(SAY_SARTHARION_SLAY);
        }

        void JustSummoned(Creature* cr)
        {
            if (cr->GetEntry() == NPC_FLAME_TSUNAMI)
                cr->SetSpeed(MOVE_FLIGHT, 1.5f);
            else if (cr->GetEntry() == NPC_FIRE_CYCLONE)
                cr->GetMotionMaster()->MoveRandom(5.0f);

            summons.Summon(cr);
        }

        void SetData(uint32 type, uint32 data)
        {
            if (type != DATA_VOLCANO_BLOWS)
                return;

            if (!volcanoBlows.empty())
                for (std::list<uint32>::const_iterator itr = volcanoBlows.begin(); itr != volcanoBlows.end(); ++itr)
                    if (data == (*itr))
                        return;

            volcanoBlows.push_back(data);
        }

        uint32 GetData(uint32 dataOrGuid) const
        {
            // it means we want dragons count
            if (dataOrGuid == DATA_ACHIEVEMENT_DRAGONS_COUNT)
                return dragonsCount;

            // otherwise it is guid to check if player was hit by lava strike :)
            if (!volcanoBlows.empty())
                for (std::list<uint32>::const_iterator itr = volcanoBlows.begin(); itr != volcanoBlows.end(); ++itr)
                    if (dataOrGuid == (*itr))
                        return true;

            return false;
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            // Special events which needs to be fired immidiately
            switch(events.GetEvent())
            {
                case EVENT_SARTHARION_BOUNDARY:
                    if (me->GetPositionX() < 3218.86f || me->GetPositionX() > 3275.69f || me->GetPositionY() < 484.68f || me->GetPositionY() > 572.4f) // https://github.com/TrinityCore/TrinityCore/blob/3.3.5/src/server/scripts/Northrend/ChamberOfAspects/ObsidianSanctum/instance_obsidian_sanctum.cpp#L31
                        EnterEvadeMode();

                    events.RepeatEvent(1000);
                break;
                case EVENT_SARTHARION_SUMMON_LAVA:
                    if (!urand(0,3))
                        Talk(SAY_SARTHARION_SPECIAL);

                    SummonLavaWaves();
                    events.RepeatEvent(25000);
                    return;
                case EVENT_SARTHARION_START_LAVA:
                    SendLavaWaves(true);
                    events.PopEvent();
                    return;
                case EVENT_SARTHARION_FINISH_LAVA:
                    SendLavaWaves(false);
                    events.PopEvent();
                    return;
            }

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            HandleSartharionAbilities();
            HandleDrakeAbilities();

            DoMeleeAttackIfReady();
        }
    };
};

void boss_sartharion::boss_sartharionAI::HandleSartharionAbilities()
{
    // Handling of Sartharion Events
    switch (events.GetEvent())
    {
        case EVENT_SARTHARION_CAST_CLEAVE:
            me->CastSpell(me->GetVictim(), SPELL_SARTHARION_CLEAVE, false);
            events.RepeatEvent(10000);
            break;
        case EVENT_SARTHARION_CAST_FLAME_BREATH:
            me->CastSpell(me->GetVictim(), SPELL_SARTHARION_FLAME_BREATH, false);
            events.RepeatEvent(20000);
            break;
        case EVENT_SARTHARION_CAST_TAIL_LASH:
            me->CastSpell(me, SPELL_SARTHARION_TAIL_LASH, false);
            events.RepeatEvent(18000);
            break;
        case EVENT_SARTHARION_LAVA_STRIKE:
            {
            if (!urand(0,2))
                Talk(SAY_SARTHARION_SPECIAL_4);

            Creature* cr = nullptr;
            summons.RemoveNotExisting();
            uint8 rand = urand(0,4); // 5 - numer of cyclones
            uint8 iter = 0;
            for (SummonList::iterator i = summons.begin(); i != summons.end(); ++i)
            {
                if ((cr = ObjectAccessor::GetCreature(*me, *i)))
                    if (cr->GetEntry() == NPC_FIRE_CYCLONE)
                    {
                        if (iter == rand)
                        {
                            cr->CastSpell(cr, SPELL_CYCLONE_AURA_PERIODIC, true);
                            break;
                        }
                        ++iter;
                    }
            }

            events.RepeatEvent(20000);
            break;
            }
        case EVENT_SARTHARION_HEALTH_CHECK:
            if (dragonsCount && !usedBerserk && me->HealthBelowPct(36))
            {
                me->CastSpell(me, SPELL_SARTHARION_BERSERK, true);
                usedBerserk = true;
                events.RepeatEvent(2000);
                break;
            }

            if (me->HealthBelowPct(11))
            {
                Creature* cr = nullptr;
                summons.RemoveNotExisting();
                for (SummonList::iterator i = summons.begin(); i != summons.end(); ++i)
                {
                    if ((cr = ObjectAccessor::GetCreature(*me, *i)))
                        if (cr->GetEntry() == NPC_FIRE_CYCLONE)
                            cr->CastSpell(cr, SPELL_CYCLONE_AURA_PERIODIC, true);
                }
                Talk(SAY_SARTHARION_BERSERK);
                events.PopEvent();
                break;
            }
            events.RepeatEvent(2000);
            break;
        case EVENT_SARTHARION_BERSERK:
            summons.DespawnEntry(NPC_SAFE_AREA_TRIGGER);
            events.PopEvent();
            break;
    }
}

void boss_sartharion::boss_sartharionAI::HandleDrakeAbilities()
{
    // Handling of Drakes Events
    switch (events.GetEvent())
    {
        // Dragon Calls
        case EVENT_SARTHARION_CALL_TENEBRON:
            Talk(SAY_SARTHARION_CALL_TENEBRON);
            if (Creature* tenebron = ObjectAccessor::GetCreature(*me, dragons[DRAGON_TENEBRON]))
                tenebron->AI()->DoAction(ACTION_CALL_DRAGON);
            events.PopEvent();
            break;
        case EVENT_SARTHARION_CALL_SHADRON:
            Talk(SAY_SARTHARION_CALL_SHADRON);
            if (Creature* shadron = ObjectAccessor::GetCreature(*me, dragons[DRAGON_SHADRON]))
                shadron->AI()->DoAction(ACTION_CALL_DRAGON);
            events.PopEvent();
            break;
        case EVENT_SARTHARION_CALL_VESPERON:
            Talk(SAY_SARTHARION_CALL_VESPERON);
            if (Creature* vesperon = ObjectAccessor::GetCreature(*me, dragons[DRAGON_VESPERON]))
                vesperon->AI()->DoAction(ACTION_CALL_DRAGON);
            events.PopEvent();
            break;
    }
}

/////////////////////////////
// TENEBRON
/////////////////////////////

class boss_sartharion_tenebron : public CreatureScript
{
public:
    boss_sartharion_tenebron() : CreatureScript("boss_sartharion_tenebron") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_sartharion_tenebronAI (pCreature);
    }

    struct boss_sartharion_tenebronAI : public ScriptedAI
    {
        boss_sartharion_tenebronAI(Creature* pCreature) : ScriptedAI(pCreature), summons(me), summons2(me)
        {
            portalGUID = 0;
            pInstance = me->GetInstanceScript();
        }

        EventMap events;
        SummonList summons;
        SummonList summons2;
        uint64 portalGUID;
        InstanceScript* pInstance;
        bool isSartharion;
        uint32 timer;

        void ClearInstance()
        {
            events.Reset();
            summons.DespawnAll();
            // Remove phase shift
            if (pInstance)
                pInstance->DoRemoveAurasDueToSpellOnPlayers(SPELL_TWILIGHT_SHIFT);

            RemoveTwilightPortal();
        }

        void RemoveTwilightPortal()
        {
            if (portalGUID)
                if (GameObject* gobj = me->GetMap()->GetGameObject(portalGUID))
                    gobj->Delete();

            portalGUID = 0;
        }

        void DoAction(int32 param)
        {
            if (param == ACTION_CALL_DRAGON)
            {
                isSartharion = true;
                timer++;
            }
        }

        void MoveInLineOfSight(Unit* who)
        {
            if (isSartharion)
                return;

            ScriptedAI::MoveInLineOfSight(who);
        }

        void Reset()
        {
            summons2.DespawnAll();
            ClearInstance();
            
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_NPC);
            me->SetDisableGravity(false);
            me->SetSpeed(MOVE_FLIGHT, 1.0f);
            me->SetCanFly(false);
            me->ResetLootMode();
            isSartharion = false;
            timer = 0;

            if (pInstance)
            {
                pInstance->SetData(BOSS_TENEBRON_EVENT, NOT_STARTED);
                pInstance->SetData(DATA_CLEAR_PORTAL, 0);
            }
        }

        void EnterCombat(Unit* )
        {
            Talk(SAY_TENEBRON_AGGRO);
            me->SetInCombatWithZone();

            if (me->IsFlying())
            {
                me->SetSpeed(MOVE_FLIGHT, 1.0f);
                me->SetCanFly(false);
            }

            events.ScheduleEvent(EVENT_MINIBOSS_SHADOW_FISSURE, 20000);
            events.ScheduleEvent(EVENT_MINIBOSS_SHADOW_BREATH, 10000);
            events.ScheduleEvent(EVENT_MINIBOSS_OPEN_PORTAL, 15000);

            if (pInstance && !isSartharion)
                pInstance->SetData(BOSS_TENEBRON_EVENT, IN_PROGRESS);

            if (isSartharion || (pInstance && pInstance->GetData(BOSS_SARTHARION_EVENT) == DONE))
                me->SetLootMode(0);

            if (isSartharion)
                if (Unit* target = SelectTarget(SELECT_TARGET_TOPAGGRO, 1, 500, true))
                    me->AI()->AttackStart(target);
        }

        void JustDied(Unit* )
        {
            Talk(SAY_TENEBRON_DEATH);

            if (!isSartharion)
            {
                ClearInstance();
                if (pInstance)
                    pInstance->SetData(BOSS_TENEBRON_EVENT, DONE);
            }
            else if (pInstance)
            {
                pInstance->SetData(DATA_CLEAR_PORTAL, 0);
                if (Creature* cr = ObjectAccessor::GetCreature(*me, pInstance->GetData64(DATA_SARTHARION)))
                    cr->AI()->DoAction(ACTION_DRAKE_DIED);
            }
        }

        void JustKilled(Unit* victim)
        {
            if (victim->GetTypeId() != TYPEID_PLAYER || urand(0,2))
                return;

            Talk(SAY_TENEBRON_SLAY);
        }

        void MovementInform(uint32 type, uint32 pointId)
        {
            if (type == WAYPOINT_MOTION_TYPE && pointId == POINT_FINAL_TENEBRON)
            {
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_NPC);
                me->SetInCombatWithZone();
            }
        }

        void UpdateAI(uint32 diff)
        {
            // Call speach
            if (timer)
            {
                timer += diff;
                if (timer >= 4000)
                {
                    Talk(SAY_TENEBRON_RESPOND);
                    me->SetCanFly(true);
                    me->SetSpeed(MOVE_FLIGHT, 3.0f);
                    me->GetMotionMaster()->MovePath(me->GetEntry()*10, false);
                    timer = 0;
                }
            }

            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.GetEvent())
            {
                case EVENT_MINIBOSS_SHADOW_BREATH:
                    if (!urand(0,10))
                        Talk(SAY_TENEBRON_BREATH);
                    me->CastSpell(me->GetVictim(), SPELL_SHADOW_BREATH, false);
                    events.RepeatEvent(17500);
                    break;
                case EVENT_MINIBOSS_SHADOW_FISSURE:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM))
                        me->CastSpell(target, SPELL_SHADOW_FISSURE, false);
                    events.RepeatEvent(22500);
                    break;
                case EVENT_MINIBOSS_OPEN_PORTAL:
                    Talk(WHISPER_OPEN_PORTAL);
                    Talk(SAY_TENEBRON_SPECIAL);
                    
                    if (!isSartharion)
                    {
                        if (GameObject* Portal = me->GetVictim()->SummonGameObject(GO_TWILIGHT_PORTAL, portalPos[BOSS_TENEBRON_EVENT].GetPositionX(), portalPos[BOSS_TENEBRON_EVENT].GetPositionY(), portalPos[BOSS_TENEBRON_EVENT].GetPositionZ(), 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0))
                            portalGUID = Portal->GetGUID();
                    }
                    else if (pInstance)
                        pInstance->SetData(DATA_ADD_PORTAL, 0);

                        
                    events.ScheduleEvent(EVENT_MINIBOSS_SPAWN_HELPERS, 2000);
                    events.RepeatEvent(60000);
                    break;
                case EVENT_MINIBOSS_SPAWN_HELPERS:
                {
                    Talk(WHISPER_HATCH_EGGS);
                    Creature* cr = nullptr;
                    for (uint8 i = 0; i < 6; ++i)
                    {
                        if ((cr = me->SummonCreature(NPC_TWILIGHT_EGG, EggsPos[isSartharion ? i+6 : i].GetPositionX(), EggsPos[isSartharion ? i+6 : i].GetPositionY(), EggsPos[isSartharion ? i+6 : i].GetPositionZ(), EggsPos[isSartharion ? i+6 : i].GetOrientation(), TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000)))
                        {
                            summons.Summon(cr);
                            cr->SetPhaseMask(16, true);
                        }
                    }

                    events.ScheduleEvent(EVENT_MINIBOSS_HATCH_EGGS, 25000);
                    events.PopEvent();
                    break;
                }
                case EVENT_MINIBOSS_HATCH_EGGS:
                {
                    Creature* cr = nullptr;
                    summons.RemoveNotExisting();
                    summons.DespawnEntry(NPC_TWILIGHT_WHELP);
                    for (SummonList::iterator i = summons.begin(); i != summons.end(); ++i)
                    {
                        if ((cr = ObjectAccessor::GetCreature(*me, *i)))
                        {
                            if (!cr->IsAlive())
                                continue;

                            if (cr->GetEntry() == NPC_TWILIGHT_EGG)
                                if ((cr = me->SummonCreature(NPC_TWILIGHT_WHELP, cr->GetPositionX(), cr->GetPositionY(), cr->GetPositionZ(), cr->GetOrientation(), TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000)))
                                    summons2.Summon(cr);
                        }
                    }

                    if (!isSartharion)
                    {
                        // Remove phase shift
                        if (InstanceScript* instance = me->GetInstanceScript())
                            instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_TWILIGHT_SHIFT);

                        RemoveTwilightPortal();
                    }
                    else if (pInstance)
                        pInstance->SetData(DATA_CLEAR_PORTAL, 0);

                    EntryCheckPredicate pred(NPC_TWILIGHT_EGG);
                    summons.DoAction(ACTION_SWITCH_PHASE, pred);
                    events.PopEvent();
                    break;
                }
            }

            DoMeleeAttackIfReady();
        }
    };
};

/////////////////////////////
// SHADRON
/////////////////////////////

class boss_sartharion_shadron : public CreatureScript
{
public:
    boss_sartharion_shadron() : CreatureScript("boss_sartharion_shadron") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_sartharion_shadronAI (pCreature);
    }

    struct boss_sartharion_shadronAI : public ScriptedAI
    {
        boss_sartharion_shadronAI(Creature* pCreature) : ScriptedAI(pCreature), summons(me)
        {
            portalGUID = 0;
            pInstance = me->GetInstanceScript();
        }

        EventMap events;
        SummonList summons;
        uint64 portalGUID;
        InstanceScript* pInstance;
        bool isSartharion;
        uint32 timer;

        void ClearInstance()
        {
            summons.DespawnAll();
            // Remove phase shift
            if (pInstance)
                pInstance->DoRemoveAurasDueToSpellOnPlayers(SPELL_TWILIGHT_SHIFT);

            RemoveTwilightPortal();
        }

        void RemoveTwilightPortal()
        {
            if (portalGUID)
                if (GameObject* gobj = me->GetMap()->GetGameObject(portalGUID))
                    gobj->Delete();

            portalGUID = 0;
        }

        void DoAction(int32 param)
        {
            if (param == ACTION_CALL_DRAGON)
            {
                isSartharion = true;
                timer++;
            }
        }

        void MoveInLineOfSight(Unit* who)
        {
            if (isSartharion)
                return;

            ScriptedAI::MoveInLineOfSight(who);
        }

        void Reset()
        {
            events.Reset();
            ClearInstance();

            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_NPC);
            me->SetSpeed(MOVE_FLIGHT, 1.0f);
            me->SetCanFly(false);
            me->ResetLootMode();
            isSartharion = false;
            timer = 0;

            if (pInstance)
            {
                pInstance->SetData(BOSS_SHADRON_EVENT, NOT_STARTED);
                pInstance->SetData(DATA_CLEAR_PORTAL, 0);
            }
        }

        void EnterCombat(Unit* )
        {
            Talk(SAY_SHADRON_AGGRO);
            me->SetInCombatWithZone();
            me->SetDisableGravity(false);
            if (me->IsFlying())
            {
                me->SetSpeed(MOVE_FLIGHT, 1.0f);
                me->SetCanFly(false);
            }

            events.ScheduleEvent(EVENT_MINIBOSS_SHADOW_FISSURE, 20000);
            events.ScheduleEvent(EVENT_MINIBOSS_SHADOW_BREATH, 10000);
            events.ScheduleEvent(EVENT_MINIBOSS_OPEN_PORTAL, 15000);
            
            if (pInstance && !isSartharion)
                pInstance->SetData(BOSS_SHADRON_EVENT, IN_PROGRESS);

            if (isSartharion || (pInstance && pInstance->GetData(BOSS_SARTHARION_EVENT) == DONE))
                me->SetLootMode(0);

            if (isSartharion)
                if (Unit* target = SelectTarget(SELECT_TARGET_TOPAGGRO, 1, 500, true))
                    me->AI()->AttackStart(target);
        }

        void JustDied(Unit* )
        {
            Talk(SAY_SHADRON_DEATH);

            if (!isSartharion)
            {
                ClearInstance();
                if (pInstance)
                    pInstance->SetData(BOSS_SHADRON_EVENT, DONE);
            }
            else if (pInstance)
            {
                if (Creature* cr = ObjectAccessor::GetCreature(*me, pInstance->GetData64(DATA_SARTHARION)))
                    cr->AI()->DoAction(ACTION_DRAKE_DIED);
            }
        }

        void JustKilled(Unit* victim)
        {
            if (victim->GetTypeId() != TYPEID_PLAYER || urand(0,2))
                return;

            Talk(SAY_SHADRON_SLAY);
        }

        void SummonedCreatureDies(Creature * /*summon*/, Unit*)
        {
            if (isSartharion && pInstance)
            {
                if (Creature* cr = ObjectAccessor::GetCreature(*me, pInstance->GetData64(DATA_SARTHARION)))
                    cr->RemoveAura(SPELL_GIFT_OF_TWILIGHT_FIRE);

                pInstance->SetData(DATA_CLEAR_PORTAL, 0);
            }
            else
            {
                ClearInstance();
                me->RemoveAura(SPELL_GIFT_OF_TWILIGHT_SHADOW);
            }

            events.ScheduleEvent(EVENT_MINIBOSS_OPEN_PORTAL, 30000);
        }

        void MovementInform(uint32 type, uint32 pointId)
        {
            if (type == WAYPOINT_MOTION_TYPE && pointId == POINT_FINAL_SHADRON)
            {
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_NPC);
                me->SetInCombatWithZone();
            }
        }

        void UpdateAI(uint32 diff)
        {
            // Call speach
            if (timer)
            {
                timer += diff;
                if (timer >= 4000)
                {
                    Talk(SAY_SHADRON_RESPOND);
                    me->SetCanFly(true);
                    me->SetSpeed(MOVE_FLIGHT, 3.0f);
                    me->GetMotionMaster()->MovePath(me->GetEntry()*10, false);
                    timer = 0;
                }
            }

            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.GetEvent())
            {
                case EVENT_MINIBOSS_SHADOW_BREATH:
                    if (!urand(0,10))
                        Talk(SAY_SHADRON_BREATH);
                    me->CastSpell(me->GetVictim(), SPELL_SHADOW_BREATH, false);
                    events.RepeatEvent(17500);
                    break;
                case EVENT_MINIBOSS_SHADOW_FISSURE:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM))
                        me->CastSpell(target, SPELL_SHADOW_FISSURE, false);
                    events.RepeatEvent(22500);
                    break;
                case EVENT_MINIBOSS_OPEN_PORTAL:
                    Talk(WHISPER_OPEN_PORTAL);
                    Talk(SAY_SHADRON_SPECIAL);
                    if (!isSartharion)
                    {
                        if (GameObject* Portal = me->GetVictim()->SummonGameObject(GO_TWILIGHT_PORTAL, portalPos[BOSS_SHADRON_EVENT].GetPositionX(), portalPos[BOSS_SHADRON_EVENT].GetPositionY(), portalPos[BOSS_SHADRON_EVENT].GetPositionZ(), 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0))
                            portalGUID = Portal->GetGUID();
                    }
                    else if (pInstance)
                        pInstance->SetData(DATA_ADD_PORTAL, 0);
                        
                    events.ScheduleEvent(EVENT_MINIBOSS_SPAWN_HELPERS, 2000);
                    events.PopEvent();
                    break;
                case EVENT_MINIBOSS_SPAWN_HELPERS:
                    Talk(WHISPER_SUMMON_DICIPLE);
                    me->CastSpell(me, (isSartharion ? SPELL_GIFT_OF_TWILIGHT_FIRE : SPELL_GIFT_OF_TWILIGHT_SHADOW), true);
                    if (Creature* cr = me->SummonCreature((isSartharion ? NPC_ACOLYTE_OF_SHADRON : NPC_DISCIPLE_OF_SHADRON), me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation()))
                    {
                        summons.Summon(cr);
                        cr->SetPhaseMask(16, true);
                    }

                    events.PopEvent();
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

/////////////////////////////
// VESPERON
/////////////////////////////

class boss_sartharion_vesperon : public CreatureScript
{
public:
    boss_sartharion_vesperon() : CreatureScript("boss_sartharion_vesperon") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_sartharion_vesperonAI (pCreature);
    }

    struct boss_sartharion_vesperonAI : public ScriptedAI
    {
        boss_sartharion_vesperonAI(Creature* pCreature) : ScriptedAI(pCreature), summons(me)
        {
            portalGUID = 0;
            pInstance = me->GetInstanceScript();
        }

        EventMap events;
        SummonList summons;
        uint64 portalGUID;
        InstanceScript* pInstance;
        bool isSartharion;
        uint32 timer;

        void ClearInstance()
        {
            // Remove phase shift
            if (pInstance)
            {
                pInstance->DoRemoveAurasDueToSpellOnPlayers(SPELL_TWILIGHT_SHIFT);
                pInstance->DoRemoveAurasDueToSpellOnPlayers(SPELL_TWILIGHT_TORMENT_VESPERON);
                pInstance->DoRemoveAurasDueToSpellOnPlayers(SPELL_TWILIGHT_TORMENT_SARTHARION);
            }

            summons.DespawnAll();
            RemoveTwilightPortal();
        }

        void RemoveTwilightPortal()
        {
            if (portalGUID)
                if (GameObject* gobj = me->GetMap()->GetGameObject(portalGUID))
                    gobj->Delete();

            portalGUID = 0;
        }

        void DoAction(int32 param)
        {
            if (param == ACTION_CALL_DRAGON)
            {
                isSartharion = true;
                timer++;
            }
        }

        void MoveInLineOfSight(Unit* who)
        {
            if (isSartharion)
                return;

            ScriptedAI::MoveInLineOfSight(who);
        }

        void Reset()
        {
            events.Reset();
            ClearInstance();

            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_NPC);
            me->SetSpeed(MOVE_FLIGHT, 1.0f);
            me->SetCanFly(false);
            me->ResetLootMode();
            isSartharion = false;
            timer = 0;

            if (pInstance)
            {
                pInstance->SetData(BOSS_VESPERON_EVENT, NOT_STARTED);
                pInstance->SetData(DATA_CLEAR_PORTAL, 1);
            }
        }

        void EnterCombat(Unit* )
        {
            Talk(SAY_VESPERON_AGGRO);
            me->SetInCombatWithZone();

            if (me->IsFlying())
            {
                me->SetSpeed(MOVE_FLIGHT, 1.0f);
                me->SetCanFly(false);
            }

            events.ScheduleEvent(EVENT_MINIBOSS_SHADOW_FISSURE, 20000);
            events.ScheduleEvent(EVENT_MINIBOSS_SHADOW_BREATH, 10000);
            events.ScheduleEvent(EVENT_MINIBOSS_OPEN_PORTAL, 30000);

            if (pInstance && !isSartharion)
                pInstance->SetData(BOSS_VESPERON_EVENT, IN_PROGRESS);

            if (isSartharion || (pInstance && pInstance->GetData(BOSS_SARTHARION_EVENT) == DONE))
                me->SetLootMode(0);

            if (isSartharion)
                if (Unit* target = SelectTarget(SELECT_TARGET_TOPAGGRO, 1, 500, true))
                    me->AI()->AttackStart(target);
        }

        void JustDied(Unit* )
        {
            Talk(SAY_VESPERON_DEATH);

            if (!isSartharion)
            {
                ClearInstance();
                if (pInstance)
                    pInstance->SetData(BOSS_VESPERON_EVENT, DONE);
            }
            else if (pInstance)
            {
                if (Creature* cr = ObjectAccessor::GetCreature(*me, pInstance->GetData64(DATA_SARTHARION)))
                    cr->AI()->DoAction(ACTION_DRAKE_DIED);
            }
        }

        void JustKilled(Unit* victim)
        {
            if (victim->GetTypeId() != TYPEID_PLAYER || urand(0,2))
                return;

            Talk(SAY_VESPERON_SLAY);
        }

        void SummonedCreatureDies(Creature * /*summon*/, Unit*)
        {
            if (!isSartharion)
                ClearInstance();
            else if (pInstance)
            {
                pInstance->DoRemoveAurasDueToSpellOnPlayers(SPELL_TWILIGHT_TORMENT_SARTHARION);
                pInstance->SetData(DATA_CLEAR_PORTAL, 1);
            }

            events.ScheduleEvent(EVENT_MINIBOSS_OPEN_PORTAL, 30000);
        }

        void MovementInform(uint32 type, uint32 pointId)
        {
            if (type == WAYPOINT_MOTION_TYPE && pointId == POINT_FINAL_VESPERON)
            {
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_NPC);
                me->SetInCombatWithZone();
            }
        }

        void UpdateAI(uint32 diff)
        {
            // Call speach
            if (timer)
            {
                timer += diff;
                if (timer >= 4000)
                {
                    Talk(SAY_VESPERON_RESPOND);
                    me->SetCanFly(true);
                    me->SetSpeed(MOVE_FLIGHT, 3.0f);
                    me->GetMotionMaster()->MovePath(me->GetEntry()*10, false);
                    timer = 0;
                }
                return;
            }

            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.GetEvent())
            {
                case EVENT_MINIBOSS_SHADOW_BREATH:
                    if (!urand(0,10))
                        Talk(SAY_SHADRON_BREATH);
                    me->CastSpell(me->GetVictim(), SPELL_SHADOW_BREATH, false);
                    events.RepeatEvent(17500);
                    break;
                case EVENT_MINIBOSS_SHADOW_FISSURE:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM))
                        me->CastSpell(target, SPELL_SHADOW_FISSURE, false);
                    events.RepeatEvent(22500);
                    break;
                case EVENT_MINIBOSS_OPEN_PORTAL:
                    Talk(WHISPER_OPEN_PORTAL);
                    Talk(SAY_VESPERON_SPECIAL);
                    if (!isSartharion)
                    {
                        if (GameObject* Portal = me->GetVictim()->SummonGameObject(GO_TWILIGHT_PORTAL, portalPos[BOSS_VESPERON_EVENT].GetPositionX(), portalPos[BOSS_VESPERON_EVENT].GetPositionY(), portalPos[BOSS_VESPERON_EVENT].GetPositionZ(), 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0))
                            portalGUID = Portal->GetGUID();
                    }
                    else if (pInstance)
                        pInstance->SetData(DATA_ADD_PORTAL, 0);
                        
                    events.ScheduleEvent(EVENT_MINIBOSS_SPAWN_HELPERS, 2000);
                    events.PopEvent();
                    break;
                case EVENT_MINIBOSS_SPAWN_HELPERS:
                    Talk(WHISPER_SUMMON_DICIPLE);
                    me->CastSpell(me, (isSartharion ? (uint32)SPELL_TWILIGHT_TORMENT_SARTHARION : (uint32)SPELL_TWILIGHT_TORMENT_VESPERON), true);
                    if (Creature* cr = me->SummonCreature((isSartharion ? NPC_ACOLYTE_OF_VESPERON : NPC_DISCIPLE_OF_VESPERON), me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation()))
                    {
                        summons.Summon(cr);
                        cr->SetPhaseMask(16, true);
                    }

                    events.PopEvent();
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

// other
class npc_twilight_summon : public CreatureScript
{
public:
    npc_twilight_summon() : CreatureScript("npc_twilight_summon") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_twilight_summonAI (pCreature);
    }

    struct npc_twilight_summonAI : public ScriptedAI
    {
        npc_twilight_summonAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
        }

        uint32 timer;
        void Reset()
        {
            timer = urand(0, 15000);
            if (me->GetEntry() == NPC_TWILIGHT_EGG)
                me->SetControlled(true, UNIT_STATE_STUNNED);
            else
                me->SetInCombatWithZone();
        }

        void DoAction(int32 param)
        {
            if (param == ACTION_SWITCH_PHASE)
            {       
                me->DespawnOrUnsummon(1);
            }
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim() || me->GetEntry() == NPC_TWILIGHT_EGG)
                return;

            timer += diff;
            if (timer >= 15000)
            {
                if (Aura* aur = me->GetVictim()->GetAura(SPELL_FADE_ARMOR))
                    aur->ModStackAmount(1);
                else
                    me->CastSpell(me->GetVictim(), SPELL_FADE_ARMOR, false);

                timer = 0;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class spell_sartharion_lava_strike : public SpellScriptLoader
{
    public:
    spell_sartharion_lava_strike() : SpellScriptLoader("spell_sartharion_lava_strike") {}

    class spell_sartharion_lava_strike_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_sartharion_lava_strike_SpellScript);

        bool spawned;

        bool Load() { spawned = false; return true; }

        void HandleDummy(SpellEffIndex /*effIndex*/)
        {
            if (!GetCaster() || !GetHitUnit())
                return;

            GetCaster()->CastSpell(GetHitUnit()->GetPositionX(), GetHitUnit()->GetPositionY(), GetHitUnit()->GetPositionZ(), SPELL_LAVA_STRIKE_DUMMY_TRIGGER, true);
        }

        void HandleSchoolDamage(SpellEffIndex /*effIndex*/)
        {
            if (!GetCaster() || !GetHitUnit() || spawned)
                return;

            if (InstanceScript* pInstance = GetCaster()->GetInstanceScript())
                if (Creature* sarth = ObjectAccessor::GetCreature(*GetHitUnit(), pInstance->GetData64(DATA_SARTHARION)))
                {
                    sarth->AI()->SetData(DATA_VOLCANO_BLOWS, GetHitUnit()->GetGUIDLow());
                    sarth->CastSpell(GetHitUnit(), SPELL_LAVA_STRIKE_SUMMON, true);
                    spawned = true;
                }
        }

        void Register()
        {
            if (m_scriptSpellId == 57578) // Dummy lava strike
                OnEffectHitTarget += SpellEffectFn(spell_sartharion_lava_strike_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            else
                OnEffectHitTarget += SpellEffectFn(spell_sartharion_lava_strike_SpellScript::HandleSchoolDamage, EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_sartharion_lava_strike_SpellScript();
    }
};

void AddSC_boss_sartharion()
{
    new boss_sartharion();
    new boss_sartharion_shadron();
    new boss_sartharion_tenebron();
    new boss_sartharion_vesperon();
    new npc_twilight_summon();

    new spell_sartharion_lava_strike();
}
