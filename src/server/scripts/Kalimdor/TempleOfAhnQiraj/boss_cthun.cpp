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

/* ScriptData
SDName: Boss_Cthun
SD%Complete: 95
SDComment: Darkglare tracking issue
SDCategory: Temple of Ahn'Qiraj
EndScriptData */

#include "Player.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "TaskScheduler.h"
#include "temple_of_ahnqiraj.h"

enum Phases
{
    PHASE_NOT_STARTED                           = 0,

    // Main Phase 1 - EYE
    PHASE_EYE_GREEN_BEAM                        = 1,
    PHASE_EYE_RED_BEAM                          = 2,

    // Main Phase 2 - CTHUN
    PHASE_CTHUN_TRANSITION                      = 3,
    PHASE_CTHUN_STOMACH                         = 4,
    PHASE_CTHUN_WEAK                            = 5,

    PHASE_CTHUN_DONE                            = 6,
};

enum Spells
{
    // ***** Main Phase 1 ********
    //Eye Spells
    SPELL_FREEZE_ANIM                           = 16245,
    SPELL_GREEN_BEAM                            = 26134,
    SPELL_DARK_GLARE                            = 26029,
    SPELL_RED_COLORATION                        = 22518,        //Probably not the right spell but looks similar

    //Eye Tentacles Spells
    SPELL_MIND_FLAY                             = 26143,

    //Claw Tentacles Spells
    SPELL_GROUND_RUPTURE                        = 26139,
    SPELL_HAMSTRING                             = 26141,

    // ***** Main Phase 2 ******
    //Body spells
    //SPELL_CARAPACE_CTHUN                        = 26156   //Was removed from client dbcs
    SPELL_TRANSFORM                             = 26232,
    SPELL_PURPLE_COLORATION                     = 22581,     //Probably not the right spell but looks similar

    //Eye Tentacles Spells
    //SAME AS PHASE1

    //Giant Claw Tentacles
    SPELL_MASSIVE_GROUND_RUPTURE                = 26478,

    //Also casts Hamstring
    SPELL_THRASH                                = 3391,

    //Giant Eye Tentacles
    //CHAIN CASTS "SPELL_GREEN_BEAM"

    //Stomach Spells
    SPELL_MOUTH_TENTACLE                        = 26332,
    SPELL_EXIT_STOMACH_KNOCKBACK                = 25383,
    SPELL_DIGESTIVE_ACID                        = 26476,

    // Tentacles
    SPELL_SUBMERGE_VISUAL                       = 26234,
    SPELL_BIRTH                                 = 26262
};

enum Actions
{
    ACTION_FLESH_TENTACLE_KILLED                = 1,

    ACTION_SPAWN_EYE_TENTACLES                  = 1,
};

enum Misc
{
    MAX_TENTACLE_GROUPS                         = 5,
    GROUP_BEAM_PHASE                            = 1
};

enum Yells
{
    //Text emote
    EMOTE_WEAKENED                              = 0,

    // ****** Out of Combat ******
    // Random Wispers - No txt only sound
    // The random sound is chosen by the client.
    RANDOM_SOUND_WHISPER                        = 8663,
};

//Stomach Teleport positions
#define STOMACH_X                           -8562.0f
#define STOMACH_Y                           2037.0f
#define STOMACH_Z                           -70.0f
#define STOMACH_O                           5.05f

//Flesh tentacle positions
const Position FleshTentaclePos[2] =
{
    { -8571.0f, 1990.0f, -98.0f, 1.22f},
    { -8525.0f, 1994.0f, -98.0f, 2.12f},
};

class NotInStomachSelector
{
public:
    NotInStomachSelector() { }

    bool operator()(Unit* unit) const
    {
        if (unit->GetTypeId() != TYPEID_PLAYER || unit->HasAura(SPELL_DIGESTIVE_ACID))
            return false;

        return true;
    }
};

//Kick out position
const Position KickPos = { -8545.0f, 1984.0f, -96.0f, 0.0f};

class boss_eye_of_cthun : public CreatureScript
{
public:
    boss_eye_of_cthun() : CreatureScript("boss_eye_of_cthun") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetTempleOfAhnQirajAI<eye_of_cthunAI>(creature);
    }

    struct eye_of_cthunAI : public ScriptedAI
    {
        eye_of_cthunAI(Creature* creature) : ScriptedAI(creature), _summons(creature)
        {
            instance = creature->GetInstanceScript();

            SetCombatMovement(false);
        }

        void Reset() override
        {
            //Dark Beam phase 35 seconds (each tick = 1 second, 35 ticks)
            DarkGlareTick = 0;
            DarkGlareAngle = 0;
            ClockWise = false;

            _eyeTentacleCounter = 0;

            //Reset flags
            me->RemoveAurasDueToSpell(SPELL_RED_COLORATION);
            me->RemoveAurasDueToSpell(SPELL_FREEZE_ANIM);
            me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);
            me->SetVisible(true);

            //Reset Phase
            instance->SetData(DATA_CTHUN_PHASE, PHASE_NOT_STARTED);

            //to avoid having a following void zone
            Creature* pPortal = me->FindNearestCreature(NPC_CTHUN_PORTAL, 10);
            if (pPortal)
                pPortal->SetReactState(REACT_PASSIVE);

            _summons.DespawnAll();
            _scheduler.CancelAll();
        }

        void EnterCombat(Unit* /*who*/) override
        {
            DoZoneInCombat();
            ScheduleTasks();
            instance->SetData(DATA_CTHUN_PHASE, PHASE_EYE_GREEN_BEAM);
        }

        void MoveInLineOfSight(Unit* who) override
        {
            if (who->GetTypeId() == TYPEID_PLAYER && !me->IsInCombat())
            {
                // Z checks are necessary here because AQ maps do funky stuff.
                if (me->IsWithinLOSInMap(who) && me->IsWithinDist2d(who, 50.0f) && who->GetPositionZ() > 100.0f)
                {
                    AttackStart(who);
                }
            }
        }

        void DoAction(int32 action) override
        {
            if (action == ACTION_SPAWN_EYE_TENTACLES)
            {
                me->SummonCreatureGroup(_eyeTentacleCounter);
                _eyeTentacleCounter++;

                if (_eyeTentacleCounter >= MAX_TENTACLE_GROUPS)
                {
                    _eyeTentacleCounter = 0;
                }
            }
        }

        void ScheduleTasks()
        {
            _scheduler.Schedule(3s, [this](TaskContext task)
            {
                DoCastRandomTarget(SPELL_GREEN_BEAM);
                task.SetGroup(GROUP_BEAM_PHASE);
                task.Repeat();
            }).Schedule(12s, [this](TaskContext task)
            {
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true))
                {
                    if (Creature* tentacle = me->SummonCreature(NPC_CLAW_TENTACLE, *target, TEMPSUMMON_CORPSE_DESPAWN, 1000))
                    {
                        tentacle->AI()->AttackStart(target);
                    }
                }

                task.SetGroup(GROUP_BEAM_PHASE);
                task.Repeat();
            }).Schedule(45s, [this](TaskContext task)
            {
                DoAction(ACTION_SPAWN_EYE_TENTACLES);
                task.SetGroup(GROUP_BEAM_PHASE);
                task.Repeat();
            }).Schedule(50s, [this](TaskContext /*task*/)
            {
                _scheduler.CancelGroup(GROUP_BEAM_PHASE);

                me->StopMoving();
                me->SetReactState(REACT_PASSIVE);
                me->InterruptNonMeleeSpells(false);
                me->SetTarget(ObjectGuid::Empty);

                _scheduler.Schedule(1s, [this](TaskContext /*task*/)
                {
                    //Select random target for dark beam to start on
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true))
                    {
                        //Face our target
                        DarkGlareAngle = me->GetAngle(target);
                        DarkGlareTick = 0;
                        ClockWise = RAND(true, false);

                        me->SetTarget(target->GetGUID());

                        //Add red coloration to C'thun
                        DoCast(me, SPELL_RED_COLORATION, true);

                        //Freeze animation
                        DoCast(me, SPELL_FREEZE_ANIM, true);

                        me->StopMoving();
                        me->SetFacingToObject(target);
                        me->SetOrientation(DarkGlareAngle);
                    }

                    _scheduler.Schedule(3s, [this](TaskContext tasker)
                    {
                        me->SetTarget(ObjectGuid::Empty);
                        me->StopMoving();

                        if (ClockWise)
                        {
                            me->SetFacingTo(DarkGlareAngle + DarkGlareTick * float(M_PI) / 35);
                            me->SetOrientation(DarkGlareAngle + DarkGlareTick * float(M_PI) / 35);

                        }
                        else
                        {
                            me->SetFacingTo(DarkGlareAngle - DarkGlareTick * float(M_PI) / 35);
                            me->SetOrientation(DarkGlareAngle - DarkGlareTick * float(M_PI) / 35);
                        }

                        DoCastSelf(SPELL_DARK_GLARE);
                        ++DarkGlareTick;

                        if (tasker.GetRepeatCounter() >= 35)
                        {
                            _scheduler.CancelAll();
                            me->SetReactState(REACT_AGGRESSIVE);
                            me->RemoveAurasDueToSpell(SPELL_RED_COLORATION);
                            me->RemoveAurasDueToSpell(SPELL_FREEZE_ANIM);
                            me->InterruptNonMeleeSpells(false);
                            ScheduleTasks();
                        }
                        else
                            tasker.Repeat(1s);
                    });
                });
            });
        }

        void JustSummoned(Creature* summon) override
        {
            _summons.Summon(summon);
            summon->SetInCombatWithZone();
        }

        void UpdateAI(uint32 diff) override
        {
            //Check if we have a target
            if (!UpdateVictim())
                return;

            switch (instance->GetData(DATA_CTHUN_PHASE))
            {
                //Transition phase
                case PHASE_CTHUN_TRANSITION:
                    //Remove any target
                    me->SetTarget();
                    me->SetHealth(0);
                    me->SetVisible(false);
                    break;

                //Dead phase
                case PHASE_CTHUN_DONE:
                    if (Creature* pPortal = me->FindNearestCreature(NPC_CTHUN_PORTAL, 10))
                    {
                        pPortal->DespawnOrUnsummon();
                    }

                    me->DespawnOrUnsummon();
                    break;
            }

            _scheduler.Update(diff);
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            switch (instance->GetData(DATA_CTHUN_PHASE))
            {
                case PHASE_EYE_GREEN_BEAM:
                case PHASE_EYE_RED_BEAM:
                    //Only if it will kill
                    if (damage < me->GetHealth())
                        return;

                    //Fake death in phase 0 or 1 (green beam or dark glare phase)
                    me->InterruptNonMeleeSpells(false);

                    //Remove Red coloration from c'thun
                    me->RemoveAurasDueToSpell(SPELL_RED_COLORATION);

                    //Reset to normal emote state and prevent select and attack
                    me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);

                    //Remove Target field
                    me->SetTarget();

                    //Death animation/respawning;
                    instance->SetData(DATA_CTHUN_PHASE, PHASE_CTHUN_TRANSITION);

                    me->SetHealth(0);
                    damage = 0;

                    me->InterruptNonMeleeSpells(true);
                    me->RemoveAllAuras();
                    break;

                case PHASE_CTHUN_DONE:
                    //Allow death here
                    return;

                default:
                    //Prevent death in these phases
                    damage = 0;
                    return;
            }
        }

        private:
            InstanceScript* instance;

            //Dark Glare phase
            uint32 DarkGlareTick;
            float DarkGlareAngle;
            bool ClockWise;

            uint32 _eyeTentacleCounter;
            TaskScheduler _scheduler;
            SummonList _summons;
    };
};

class boss_cthun : public CreatureScript
{
public:
    boss_cthun() : CreatureScript("boss_cthun") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetTempleOfAhnQirajAI<cthunAI>(creature);
    }

    struct cthunAI : public ScriptedAI
    {
        cthunAI(Creature* creature) : ScriptedAI(creature)
        {
            SetCombatMovement(false);

            instance = creature->GetInstanceScript();
        }

        InstanceScript* instance;

        //Out of combat whisper timer
        uint32 WisperTimer;

        //Global variables
        uint32 PhaseTimer;

        //-------------------

        //Phase transition
        ObjectGuid HoldPlayer;

        //Body Phase
        uint32 EyeTentacleTimer;
        uint8 FleshTentaclesKilled;
        uint32 GiantClawTentacleTimer;
        uint32 GiantEyeTentacleTimer;
        uint32 StomachAcidTimer;
        uint32 StomachEnterTimer;
        uint32 StomachEnterVisTimer;
        ObjectGuid StomachEnterTarget;

        //Stomach map, bool = true then in stomach
        std::unordered_map<ObjectGuid, bool> Stomach_Map;

        void Reset() override
        {
            //One random wisper every 90 - 300 seconds
            WisperTimer = 90000;

            //Phase information
            PhaseTimer = 10000;                                 //Emerge in 10 seconds

            //No hold player for transition
            HoldPlayer.Clear();

            //Body Phase
            EyeTentacleTimer = 30000;
            FleshTentaclesKilled = 0;
            GiantClawTentacleTimer = 15000;                     //15 seconds into body phase (1 min repeat)
            GiantEyeTentacleTimer = 45000;                      //15 seconds into body phase (1 min repeat)
            StomachAcidTimer = 4000;                            //Every 4 seconds
            StomachEnterTimer = 10000;                          //Every 10 seconds
            StomachEnterVisTimer = 0;                           //Always 3.5 seconds after Stomach Enter Timer
            StomachEnterTarget.Clear();                         //Target to be teleported to stomach

            //Clear players in stomach and outside
            Stomach_Map.clear();

            //Reset flags
            me->RemoveAurasDueToSpell(SPELL_TRANSFORM);
            me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);
            me->SetVisible(false);

            instance->SetData(DATA_CTHUN_PHASE, PHASE_NOT_STARTED);
        }

        void EnterCombat(Unit* /*who*/) override
        {
            DoZoneInCombat();
        }

        Unit* SelectRandomNotStomach()
        {
            if (Stomach_Map.empty())
                return nullptr;

            std::unordered_map<ObjectGuid, bool>::const_iterator i = Stomach_Map.begin();

            std::list<Unit*> temp;
            std::list<Unit*>::const_iterator j;

            //Get all players in map
            while (i != Stomach_Map.end())
            {
                //Check for valid player
                Unit* unit = ObjectAccessor::GetUnit(*me, i->first);

                //Only units out of stomach
                if (unit && !i->second)
                    temp.push_back(unit);

                ++i;
            }

            if (temp.empty())
                return nullptr;

            j = temp.begin();

            //Get random but only if we have more than one unit on threat list
            if (temp.size() > 1)
                advance (j, rand() % (temp.size() - 1));

            return (*j);
        }

        void UpdateAI(uint32 diff) override
        {
            //Check if we have a target
            if (!UpdateVictim())
            {
                //No target so we'll use this section to do our random wispers instance wide
                //WisperTimer
                if (WisperTimer <= diff)
                {
                    Map* map = me->GetMap();
                    if (!map->IsDungeon())
                        return;

                    //Play random sound to the zone
                    Map::PlayerList const& PlayerList = map->GetPlayers();

                    if (!PlayerList.IsEmpty())
                    {
                        for (Map::PlayerList::const_iterator itr = PlayerList.begin(); itr != PlayerList.end(); ++itr)
                        {
                            if (Player* pPlr = itr->GetSource())
                                pPlr->PlayDirectSound(RANDOM_SOUND_WHISPER, pPlr);
                        }
                    }

                    //One random wisper every 90 - 300 seconds
                    WisperTimer = urand(90000, 300000);
                }
                else WisperTimer -= diff;

                return;
            }

            me->SetTarget();

            uint32 currentPhase = instance->GetData(DATA_CTHUN_PHASE);
            if (currentPhase == PHASE_CTHUN_STOMACH || currentPhase == PHASE_CTHUN_WEAK)
            {
                // EyeTentacleTimer
                if (EyeTentacleTimer <= diff)
                {
                    if (Creature* eye = instance->GetCreature(DATA_EYE_OF_CTHUN))
                    {
                        eye->AI()->DoAction(ACTION_SPAWN_EYE_TENTACLES);
                    }

                    EyeTentacleTimer = 30000; // every 30sec in phase 2
                }
                else EyeTentacleTimer -= diff;
            }

            switch (currentPhase)
            {
                //Transition phase
                case PHASE_CTHUN_TRANSITION:
                    //PhaseTimer
                    if (PhaseTimer <= diff)
                    {
                        //Switch
                        instance->SetData(DATA_CTHUN_PHASE, PHASE_CTHUN_STOMACH);

                        //Switch to c'thun model
                        me->InterruptNonMeleeSpells(false);
                        DoCast(me, SPELL_TRANSFORM, false);
                        me->SetFullHealth();

                        me->SetVisible(true);
                        me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);

                        //Emerging phase
                        //AttackStart(ObjectAccessor::GetUnit(*me, HoldpPlayer));
                        DoZoneInCombat();

                        //Place all units in threat list on outside of stomach
                        Stomach_Map.clear();

                        for (std::list<HostileReference*>::const_iterator i = me->GetThreatMgr().getThreatList().begin(); i != me->GetThreatMgr().getThreatList().end(); ++i)
                            Stomach_Map[(*i)->getUnitGuid()] = false;   //Outside stomach

                        //Spawn 2 flesh tentacles
                        FleshTentaclesKilled = 0;

                        //Spawn flesh tentacle
                        for (uint8 i = 0; i < 2; i++)
                        {
                            Creature* spawned = me->SummonCreature(NPC_FLESH_TENTACLE, FleshTentaclePos[i], TEMPSUMMON_CORPSE_DESPAWN);
                            if (!spawned)
                                ++FleshTentaclesKilled;
                        }

                        PhaseTimer = 0;
                    }
                    else PhaseTimer -= diff;

                    break;

                //Body Phase
                case PHASE_CTHUN_STOMACH:
                    //Remove Target field
                    me->SetTarget();

                    //Weaken
                    if (FleshTentaclesKilled > 1)
                    {
                        instance->SetData(DATA_CTHUN_PHASE, PHASE_CTHUN_WEAK);

                        Talk(EMOTE_WEAKENED);
                        PhaseTimer = 45000;

                        DoCast(me, SPELL_PURPLE_COLORATION, true);

                        std::unordered_map<ObjectGuid, bool>::iterator i = Stomach_Map.begin();

                        //Kick all players out of stomach
                        while (i != Stomach_Map.end())
                        {
                            //Check for valid player
                            Unit* unit = ObjectAccessor::GetUnit(*me, i->first);

                            //Only move units in stomach
                            if (unit && i->second)
                            {
                                //Teleport each player out
                                DoTeleportPlayer(unit, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ() + 10, float(rand() % 6));

                                //Cast knockback on them
                                DoCast(unit, SPELL_EXIT_STOMACH_KNOCKBACK, true);

                                //Remove the acid debuff
                                unit->RemoveAurasDueToSpell(SPELL_DIGESTIVE_ACID);

                                i->second = false;
                            }
                            ++i;
                        }

                        return;
                    }

                    //Stomach acid
                    if (StomachAcidTimer <= diff)
                    {
                        //Apply aura to all players in stomach
                        std::unordered_map<ObjectGuid, bool>::iterator i = Stomach_Map.begin();

                        while (i != Stomach_Map.end())
                        {
                            //Check for valid player
                            Unit* unit = ObjectAccessor::GetUnit(*me, i->first);

                            //Only apply to units in stomach
                            if (unit && i->second)
                            {
                                //Cast digestive acid on them
                                DoCast(unit, SPELL_DIGESTIVE_ACID, true);

                                //Check if player should be kicked from stomach
                                if (unit->IsWithinDist3d(&KickPos, 15.0f))
                                {
                                    //Teleport each player out
                                    DoTeleportPlayer(unit, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ() + 10, float(rand() % 6));

                                    //Cast knockback on them
                                    DoCast(unit, SPELL_EXIT_STOMACH_KNOCKBACK, true);

                                    //Remove the acid debuff
                                    unit->RemoveAurasDueToSpell(SPELL_DIGESTIVE_ACID);

                                    i->second = false;
                                }
                            }
                            ++i;
                        }

                        StomachAcidTimer = 4000;
                    }
                    else StomachAcidTimer -= diff;

                    //Stomach Enter Timer
                    if (StomachEnterTimer <= diff)
                    {
                        if (Unit* target = SelectRandomNotStomach())
                        {
                            //Set target in stomach
                            Stomach_Map[target->GetGUID()] = true;
                            target->InterruptNonMeleeSpells(false);
                            target->CastSpell(target, SPELL_MOUTH_TENTACLE, true, nullptr, nullptr, me->GetGUID());
                            StomachEnterTarget = target->GetGUID();
                            StomachEnterVisTimer = 3800;
                        }

                        StomachEnterTimer = 13800;
                    }
                    else StomachEnterTimer -= diff;

                    if (StomachEnterVisTimer && StomachEnterTarget)
                    {
                        if (StomachEnterVisTimer <= diff)
                        {
                            //Check for valid player
                            Unit* unit = ObjectAccessor::GetUnit(*me, StomachEnterTarget);

                            if (unit)
                            {
                                DoTeleportPlayer(unit, STOMACH_X, STOMACH_Y, STOMACH_Z, STOMACH_O);
                            }

                            StomachEnterTarget.Clear();
                            StomachEnterVisTimer = 0;
                        }
                        else StomachEnterVisTimer -= diff;
                    }

                    //GientClawTentacleTimer
                    if (GiantClawTentacleTimer <= diff)
                    {
                        if (Unit* target = SelectRandomNotStomach())
                        {
                            //Spawn claw tentacle on the random target
                            if (Creature* spawned = me->SummonCreature(NPC_GIANT_CLAW_TENTACLE, *target, TEMPSUMMON_CORPSE_DESPAWN, 500))
                                if (spawned->AI())
                                    spawned->AI()->AttackStart(target);
                        }

                        //One giant claw tentacle every minute
                        GiantClawTentacleTimer = 60000;
                    }
                    else GiantClawTentacleTimer -= diff;

                    //GiantEyeTentacleTimer
                    if (GiantEyeTentacleTimer <= diff)
                    {
                        if (Unit* target = SelectRandomNotStomach())
                        {
                            //Spawn claw tentacle on the random target
                            if (Creature* spawned = me->SummonCreature(NPC_GIANT_EYE_TENTACLE, *target, TEMPSUMMON_CORPSE_DESPAWN, 500))
                                if (spawned->AI())
                                    spawned->AI()->AttackStart(target);
                        }

                        //One giant eye tentacle every minute
                        GiantEyeTentacleTimer = 60000;
                    }
                    else GiantEyeTentacleTimer -= diff;

                    break;

                //Weakened state
                case PHASE_CTHUN_WEAK:
                    //PhaseTimer
                    if (PhaseTimer <= diff)
                    {
                        //Switch
                        instance->SetData(DATA_CTHUN_PHASE, PHASE_CTHUN_STOMACH);

                        //Remove purple coloration
                        me->RemoveAurasDueToSpell(SPELL_PURPLE_COLORATION);

                        //Spawn 2 flesh tentacles
                        FleshTentaclesKilled = 0;

                        //Spawn flesh tentacle
                        for (uint8 i = 0; i < 2; i++)
                        {
                            Creature* spawned = me->SummonCreature(NPC_FLESH_TENTACLE, FleshTentaclePos[i], TEMPSUMMON_CORPSE_DESPAWN);
                            if (!spawned)
                                ++FleshTentaclesKilled;
                        }

                        PhaseTimer = 0;
                    }
                    else PhaseTimer -= diff;

                    break;
            }
        }

        void JustDied(Unit* /*killer*/) override
        {
            instance->SetData(DATA_CTHUN_PHASE, PHASE_CTHUN_DONE);
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            switch (instance->GetData(DATA_CTHUN_PHASE))
            {
                case PHASE_CTHUN_STOMACH:
                    //Not weakened so reduce damage by 99%
                    damage /= 100;
                    if (damage == 0)
                        damage = 1;

                    //Prevent death in non-weakened state
                    if (damage >= me->GetHealth())
                        damage = 0;

                    return;

                case PHASE_CTHUN_WEAK:
                    //Weakened - takes normal damage
                    return;

                default:
                    damage = 0;
                    break;
            }
        }

        void DoAction(int32 param) override
        {
            switch (param)
            {
                case ACTION_FLESH_TENTACLE_KILLED:
                    ++FleshTentaclesKilled;
                    break;
            }
        }
    };
};

class npc_eye_tentacle : public CreatureScript
{
public:
    npc_eye_tentacle() : CreatureScript("npc_eye_tentacle") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new eye_tentacleAI(creature);
    }

    struct eye_tentacleAI : public ScriptedAI
    {
        eye_tentacleAI(Creature* creature) : ScriptedAI(creature)
        {
            if (Creature* portal = me->SummonCreature(NPC_SMALL_PORTAL, *me, TEMPSUMMON_CORPSE_DESPAWN))
            {
                portal->SetReactState(REACT_PASSIVE);
                _portalGUID = portal->GetGUID();
            }

            SetCombatMovement(false);
        }

        void JustDied(Unit* /*killer*/) override
        {
            if (Unit* p = ObjectAccessor::GetUnit(*me, _portalGUID))
            {
                Unit::Kill(p, p);
            }
        }

        void Reset() override
        {
            _scheduler.Schedule(500ms, [this](TaskContext /*task*/)
            {
                DoCastAOE(SPELL_GROUND_RUPTURE);
            }).Schedule(5min, [this](TaskContext /*task*/)
            {
                me->DespawnOrUnsummon();
            }).Schedule(1s, 5s, [this](TaskContext context)
            {
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, [&](Unit* u) { return u && u->GetTypeId() == TYPEID_PLAYER && !u->HasAura(SPELL_DIGESTIVE_ACID) && !u->HasAura(SPELL_MIND_FLAY); }))
                {
                   DoCast(target, SPELL_MIND_FLAY);
                }

                context.Repeat(10s, 15s);
            });
        }

        void EnterCombat(Unit* /*who*/) override
        {
            DoZoneInCombat();
        }

        void UpdateAI(uint32 diff) override
        {
            //Check if we have a target
            if (!UpdateVictim())
                return;

            _scheduler.Update(diff);
        }

    private:
        TaskScheduler _scheduler;
        ObjectGuid _portalGUID;
    };
};

class npc_claw_tentacle : public CreatureScript
{
public:
    npc_claw_tentacle() : CreatureScript("npc_claw_tentacle") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new claw_tentacleAI(creature);
    }

    struct claw_tentacleAI : public ScriptedAI
    {
        claw_tentacleAI(Creature* creature) : ScriptedAI(creature)
        {
            SetCombatMovement(false);

            if (Creature* portal = me->SummonCreature(NPC_SMALL_PORTAL, *me, TEMPSUMMON_CORPSE_DESPAWN))
            {
                portal->SetReactState(REACT_PASSIVE);
                _portalGUID = portal->GetGUID();
            }
        }

        void JustDied(Unit* /*killer*/) override
        {
            if (Unit* p = ObjectAccessor::GetUnit(*me, _portalGUID))
            {
                Unit::Kill(p, p);
            }
        }

        void Reset() override
        {
            _scheduler.Schedule(Milliseconds(500), [this](TaskContext /*task*/)
            {
                DoCastAOE(SPELL_GROUND_RUPTURE);
            }).Schedule(Minutes(5), [this](TaskContext /*task*/)
            {
                me->DespawnOrUnsummon();
            });
        }

        void EnterCombat(Unit* /*who*/) override
        {
            DoZoneInCombat();

            _scheduler.Schedule(2s, [this](TaskContext context)
            {
                DoCastVictim(SPELL_HAMSTRING);
                context.Repeat(5s);
            });
        }

        void UpdateAI(uint32 diff) override
        {
            //Check if we have a target
            if (!UpdateVictim())
                return;

            _scheduler.Update(diff);

            DoMeleeAttackIfReady();
        }

    private:
        TaskScheduler _scheduler;
        ObjectGuid _portalGUID;
    };
};

class npc_giant_claw_tentacle : public CreatureScript
{
public:
    npc_giant_claw_tentacle() : CreatureScript("npc_giant_claw_tentacle") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new giant_claw_tentacleAI(creature);
    }

    struct giant_claw_tentacleAI : public ScriptedAI
    {
        giant_claw_tentacleAI(Creature* creature) : ScriptedAI(creature)
        {
            SetCombatMovement(false);

            if (Creature* portal = me->SummonCreature(NPC_GIANT_PORTAL, *me, TEMPSUMMON_CORPSE_DESPAWN))
            {
                portal->SetReactState(REACT_PASSIVE);
                _portalGUID = portal->GetGUID();
            }
        }

        void JustDied(Unit* /*killer*/) override
        {
            if (Unit* p = ObjectAccessor::GetUnit(*me, _portalGUID))
            {
                Unit::Kill(p, p);
            }
        }

        void Reset() override
        {
            _scheduler.Schedule(500ms, [this](TaskContext /*task*/)
            {
                DoCastAOE(SPELL_MASSIVE_GROUND_RUPTURE);
            });
        }

        void EnterCombat(Unit* /*who*/) override
        {
            DoZoneInCombat();

            _scheduler.Schedule(2s, [this](TaskContext context)
            {
                DoCastVictim(SPELL_HAMSTRING);
                context.Repeat(10s);
            }).Schedule(5s, [this](TaskContext context) {
                DoCastSelf(SPELL_THRASH);
                context.Repeat(10s);
            });
        }

        void ScheduleMeleeCheck()
        {
            // Check if a target is in melee range
            _scheduler.Schedule(10s, [this](TaskContext task)
            {
                if (Unit* target = me->GetVictim())
                {
                    if (!target->IsWithinMeleeRange(me))
                    {
                        // Main target not found within melee range, try to select a new one
                        if (Player* newTarget = me->SelectNearestPlayer(5.0f))
                        {
                            AttackStart(newTarget);
                        }
                        else // Main target not found, and failed to acquire a new target... Submerge
                        {
                            Submerge();
                        }
                    }
                }

                task.Repeat();
            });
        }

        void Submerge()
        {
            if (me->SelectNearestPlayer(5.0f))
            {
                return;
            }

            // Despawn portal
            if (Creature* p = ObjectAccessor::GetCreature(*me, _portalGUID))
            {
                p->DespawnOrUnsummon();
            }

            DoCastSelf(SPELL_SUBMERGE_VISUAL);
            me->SetHealth(me->GetMaxHealth());
            me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);

            _scheduler.CancelAll();

            _scheduler.Schedule(5s, [this](TaskContext /*task*/)
            {
                Emerge();
            });
        }

        void Emerge()
        {
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, NotInStomachSelector()))
            {
                Position pos = target->GetPosition();
                me->NearTeleportTo(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), 0);
                if (Creature* portal = me->SummonCreature(NPC_GIANT_PORTAL, pos, TEMPSUMMON_CORPSE_DESPAWN))
                {
                    portal->SetReactState(REACT_PASSIVE);
                    _portalGUID = portal->GetGUID();
                }

                me->RemoveAurasDueToSpell(SPELL_SUBMERGE_VISUAL);
                DoCastSelf(SPELL_BIRTH);
                DoCastAOE(SPELL_MASSIVE_GROUND_RUPTURE, true);
                me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);

                ScheduleMeleeCheck();
            }
        }

        void UpdateAI(uint32 diff) override
        {
            //Check if we have a target
            if (!UpdateVictim())
                return;

            _scheduler.Update(diff);

            DoMeleeAttackIfReady();
        }

    private:
        TaskScheduler _scheduler;
        ObjectGuid _portalGUID;
    };
};

class npc_giant_eye_tentacle : public CreatureScript
{
public:
    npc_giant_eye_tentacle() : CreatureScript("npc_giant_eye_tentacle") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new giant_eye_tentacleAI(creature);
    }

    struct giant_eye_tentacleAI : public ScriptedAI
    {
        giant_eye_tentacleAI(Creature* creature) : ScriptedAI(creature)
        {
            SetCombatMovement(false);

            if (Creature* portal = me->SummonCreature(NPC_GIANT_PORTAL, *me, TEMPSUMMON_CORPSE_DESPAWN))
            {
                portal->SetReactState(REACT_PASSIVE);
                _portalGUID = portal->GetGUID();
            }
        }

        void JustDied(Unit* /*killer*/) override
        {
            if (Unit* p = ObjectAccessor::GetUnit(*me, _portalGUID))
            {
                Unit::Kill(p, p);
            }
        }

        void Reset() override
        {
            _scheduler.Schedule(500ms, [this](TaskContext /*task*/)
            {
                DoCastAOE(SPELL_MASSIVE_GROUND_RUPTURE);
            }).Schedule(1s, 5s, [this](TaskContext context) {
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true, -SPELL_DIGESTIVE_ACID))
                {
                    DoCast(target, SPELL_GREEN_BEAM);
                }

                context.Repeat(2100ms);
            });
        }

        void EnterCombat(Unit* /*who*/) override
        {
            DoZoneInCombat();
        }

        void UpdateAI(uint32 diff) override
        {
            //Check if we have a target
            if (!UpdateVictim())
                return;

            _scheduler.Update(diff);
        }

    private:
        TaskScheduler _scheduler;
        ObjectGuid _portalGUID;
    };
};

class npc_giant_flesh_tentacle : public CreatureScript
{
public:
    npc_giant_flesh_tentacle() : CreatureScript("npc_giant_flesh_tentacle") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new flesh_tentacleAI(creature);
    }

    struct flesh_tentacleAI : public ScriptedAI
    {
        flesh_tentacleAI(Creature* creature) : ScriptedAI(creature)
        {
            SetCombatMovement(false);
        }

        void JustDied(Unit* /*killer*/) override
        {
            if (TempSummon* summon = me->ToTempSummon())
                if (Unit* summoner = summon->GetSummonerUnit())
                    if (summoner->IsAIEnabled)
                        summoner->GetAI()->DoAction(ACTION_FLESH_TENTACLE_KILLED);
        }
    };
};

//GetAIs

void AddSC_boss_cthun()
{
    new boss_eye_of_cthun();
    new boss_cthun();
    new npc_eye_tentacle();
    new npc_claw_tentacle();
    new npc_giant_claw_tentacle();
    new npc_giant_eye_tentacle();
    new npc_giant_flesh_tentacle();
}
