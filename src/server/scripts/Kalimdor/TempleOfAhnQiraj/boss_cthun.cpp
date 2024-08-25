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

#include "AreaTriggerScript.h"
#include "CreatureScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "temple_of_ahnqiraj.h"
/* ScriptData
SDName: Boss_Cthun
SD%Complete: 95
SDComment: Darkglare tracking issue
SDCategory: Temple of Ahn'Qiraj
EndScriptData */

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
    SPELL_CARAPACE_CTHUN                        = 26156,     // Server-side
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
    SPELL_BIRTH                                 = 26262,
    SPELL_ROCKY_GROUND_IMPACT                   = 26271,

    // Areatriggers
    SPELL_SPIT_OUT                              = 25383,
    SPELL_EXIT_STOMACH                          = 26221,
    SPELL_RUBBLE_ROCKY                          = 26271
};

enum Actions
{
    ACTION_FLESH_TENTACLE_KILLED                = 1,

    ACTION_SPAWN_EYE_TENTACLES                  = 1,

    ACTION_START_PHASE_TWO                      = 1,
};

enum TaskGroups
{
    GROUP_BEAM_PHASE = 1
};

enum Phases
{
    PHASE_BODY = 2
};

enum Misc
{
    MAX_TENTACLE_GROUPS                         = 5,
    NPC_TRIGGER                                 = 15384,
    NPC_EXIT_TRIGGER                            = 15800
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
        return unit->IsPlayer() && !unit->HasAura(SPELL_DIGESTIVE_ACID) && (unit->GetPositionZ() > 0.0f);
    }
};

//Kick out position
const Position KickPos = { -8545.0f, 1984.0f, -96.0f, 0.0f};

struct boss_eye_of_cthun : public BossAI
{
    boss_eye_of_cthun(Creature* creature) : BossAI(creature, DATA_CTHUN)
    {
        me->SetCombatMovement(false);
        me->m_SightDistance = 90.f;
    }

    void Reset() override
    {
        //Dark Beam phase 35 seconds (each tick = 1 second, 35 ticks)
        DarkGlareTick = 0;
        DarkGlareAngle = 0;
        ClockWise = false;

        _eyeTentacleCounter = 0;

        //Reset flags
        me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);
        me->SetVisible(true);

        //to avoid having a following void zone
        Creature* pPortal = me->FindNearestCreature(NPC_CTHUN_PORTAL, 10);
        if (pPortal)
            pPortal->SetReactState(REACT_PASSIVE);

        BossAI::Reset();
    }

    void JustDied(Unit* /*killer*/) override
    {
        if (Creature* cthun = instance->GetCreature(DATA_CTHUN))
        {
            cthun->AI()->DoAction(ACTION_START_PHASE_TWO);
        }
    }

    void JustEngagedWith(Unit* who) override
    {
        ScheduleTask(true);
        BossAI::JustEngagedWith(who);
        _beamTarget = who->GetGUID();
    }

    void MoveInLineOfSight(Unit* who) override
    {
        if (who->IsPlayer() && !me->IsInCombat())
        {
            // Z checks are necessary here because AQ maps do funky stuff.
            if (me->IsWithinLOSInMap(who) && me->IsWithinDist2d(who, 90.0f) && who->GetPositionZ() > 100.0f)
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

    void JustSummoned(Creature* summon) override
    {
        summons.Summon(summon);

        if (Creature* cthun = instance->GetCreature(DATA_CTHUN))
        {
            cthun->AI()->JustSummoned(summon);
        }
    }

    void ScheduleTask(bool onEngage = false)
    {
        scheduler.
            Schedule(3s, [this, onEngage](TaskContext task)
            {
                if (task.GetRepeatCounter() < 3 && onEngage)
                {
                    if (Unit* target = ObjectAccessor::GetUnit(*me, _beamTarget))
                    {
                        DoCast(target, SPELL_GREEN_BEAM);
                    }

                    task.Repeat();
                }
                else
                {
                    scheduler.Schedule(5s, [this](TaskContext task)
                    {
                        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true))
                        {
                            DoCast(target, SPELL_GREEN_BEAM);
                            DarkGlareAngle = me->GetAngle(target); //keep as the location dark glare will be at
                        }

                        task.SetGroup(GROUP_BEAM_PHASE);
                        task.Repeat(3s);
                    });
                }

                task.SetGroup(GROUP_BEAM_PHASE);
            })
            .Schedule(8s, [this](TaskContext task)
            {
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true))
                {
                    if (Creature* tentacle = me->SummonCreature(NPC_CLAW_TENTACLE, *target, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000))
                    {
                        tentacle->AI()->AttackStart(target);
                    }
                }

                task.SetGroup(GROUP_BEAM_PHASE);
                task.Repeat();
            })
            .Schedule(45s, [this](TaskContext task)
            {
                DoAction(ACTION_SPAWN_EYE_TENTACLES);
                task.SetGroup(GROUP_BEAM_PHASE);
                task.Repeat();
            })
            .Schedule(46s, [this](TaskContext /*task*/)
            {
                scheduler.CancelGroup(GROUP_BEAM_PHASE);

                me->StopMoving();
                me->SetReactState(REACT_PASSIVE);
                me->InterruptNonMeleeSpells(false);
                me->SetTarget(ObjectGuid::Empty);

                //Freeze animation
                DoCast(me, SPELL_FREEZE_ANIM, true);

                scheduler.Schedule(1s, [this](TaskContext /*task*/)
                {
                    //Select last target that had a beam cast on it
                    //Face our target

                    DarkGlareTick = 0;
                    ClockWise = RAND(true, false);

                    //Add red coloration to C'thun
                    DoCast(me, SPELL_RED_COLORATION, true);

                    me->StopMoving();
                    me->SetOrientation(DarkGlareAngle);
                    me->SetFacingTo(DarkGlareAngle);

                    scheduler.Schedule(3s, [this](TaskContext tasker)
                    {
                        me->SetTarget(ObjectGuid::Empty);
                        me->StopMoving();

                        float angle = ClockWise ? DarkGlareAngle + DarkGlareTick * float(M_PI) / 35 : DarkGlareAngle - DarkGlareTick * float(M_PI) / 35;
                        me->SetFacingTo(angle);
                        me->SetOrientation(angle);

                        DoCastSelf(SPELL_DARK_GLARE);

                        ++DarkGlareTick;

                        if (tasker.GetRepeatCounter() >= 35)
                        {
                            scheduler.CancelAll();
                            me->SetReactState(REACT_AGGRESSIVE);
                            me->RemoveAurasDueToSpell(SPELL_RED_COLORATION);
                            me->RemoveAurasDueToSpell(SPELL_FREEZE_ANIM);
                            me->InterruptNonMeleeSpells(false);
                            ScheduleTask();
                        }
                        else
                            tasker.Repeat(1s);
                    });
                });
            });
    }

    void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
    {
        //Only if it will kill
        if (damage < me->GetHealth() || !me->GetHealth())
            return;

        //Fake death in phase 0 or 1 (green beam or dark glare phase)
        me->InterruptNonMeleeSpells(false);

        //Remove Red coloration from c'thun
        me->RemoveAurasDueToSpell(SPELL_RED_COLORATION);

        //Reset to normal emote state and prevent select and attack
        me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);

        //Remove Target field
        me->SetTarget();

        me->SetHealth(0);
        damage = 0;

        me->InterruptNonMeleeSpells(true);
        me->RemoveAllAuras();
        scheduler.CancelAll();

        me->m_Events.AddEventAtOffset([this]()
        {
            if (Creature* cthun = instance->GetCreature(DATA_CTHUN))
            {
                cthun->AI()->DoAction(ACTION_START_PHASE_TWO);
            }
        }, 3s);
    }

private:
    //Dark Glare phase
    uint32 DarkGlareTick;
    float DarkGlareAngle;
    bool ClockWise;

    uint32 _eyeTentacleCounter;
    ObjectGuid _beamTarget;
};

struct boss_cthun : public BossAI
{
    boss_cthun(Creature* creature) : BossAI(creature, DATA_CTHUN)
    {
        me->SetCombatMovement(false);
    }

    void Reset() override
    {
        //One random wisper every 90 - 300 seconds
        WisperTimer = 90000;

        _fleshTentaclesKilled = 0;

        //Reset flags
        me->RemoveAurasDueToSpell(SPELL_TRANSFORM);
        me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);

        BossAI::Reset();
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        DoZoneInCombat();
    }

    void DoAction(int32 actionId) override
    {
        if (actionId == ACTION_START_PHASE_TWO)
        {
            // Animation only plays if Cthun already has this aura...
            DoCastSelf(SPELL_TRANSFORM);

            me->m_Events.AddEventAtOffset([this]()
            {
                DoCastSelf(SPELL_TRANSFORM);
                DoCastSelf(SPELL_CARAPACE_CTHUN, true);
                me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);
                DoZoneInCombat();
            }, 500ms);

            //Spawn flesh tentacle
            for (uint8 i = 0; i < 2; i++)
            {
                me->SummonCreature(NPC_FLESH_TENTACLE, FleshTentaclePos[i], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);
            }

            ScheduleTasks();
        }
    }

    void ScheduleTasks() override
    {
        scheduler.Schedule(13800ms, [this](TaskContext context)
        {
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, NotInStomachSelector()))
            {
                target->CastSpell(target, SPELL_MOUTH_TENTACLE, true);

                target->m_Events.AddEventAtOffset([target, this]()
                {
                    DoTeleportPlayer(target, STOMACH_X, STOMACH_Y, STOMACH_Z, STOMACH_O);
                    target->RemoveAurasDueToSpell(SPELL_MIND_FLAY);

                    target->m_Events.AddEventAtOffset([target, this]()
                    {
                        DoCast(target, SPELL_DIGESTIVE_ACID, true);
                    }, 2s);
                }, 3800ms);
            }

            context.Repeat();
        }).Schedule(30s, [this](TaskContext context)
        {
            if (Creature* eye = instance->GetCreature(DATA_EYE_OF_CTHUN))
            {
                eye->AI()->DoAction(ACTION_SPAWN_EYE_TENTACLES);
            }

            context.Repeat(30s);
        }).Schedule(8s, [this](TaskContext context)
        {
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, NotInStomachSelector()))
            {
                //Spawn claw tentacle on the random target
                if (Creature* spawned = me->SummonCreature(NPC_GIANT_CLAW_TENTACLE, *target, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000))
                {
                    spawned->AI()->AttackStart(target);
                }
            }

            context.Repeat(1min);
        }).Schedule(38s, [this](TaskContext context)
        {
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, NotInStomachSelector()))
            {
                //Spawn claw tentacle on the random target
                if (Creature* spawned = me->SummonCreature(NPC_GIANT_EYE_TENTACLE, *target, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000))
                {
                    spawned->AI()->AttackStart(target);
                }
            }

            context.Repeat(1min);
        });
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

        scheduler.Update(diff);
    }

    void JustDied(Unit* killer) override
    {
        BossAI::JustDied(killer);

        if (Creature* pPortal = me->FindNearestCreature(NPC_CTHUN_PORTAL, 10.0f))
        {
            pPortal->DespawnOrUnsummon();
        }

        if (Creature* eye = instance->GetCreature(DATA_EYE_OF_CTHUN))
        {
            eye->DespawnOrUnsummon();
        }
    }

    void SummonedCreatureDies(Creature* creature, Unit* /*killer*/) override
    {
        if (creature->GetEntry() == NPC_FLESH_TENTACLE)
        {
            ++_fleshTentaclesKilled;

            creature->CastSpell(creature, SPELL_ROCKY_GROUND_IMPACT, true);

            if (_fleshTentaclesKilled > 1)
            {
                scheduler.CancelAll();

                _fleshTentaclesKilled = 0;

                Talk(EMOTE_WEAKENED);

                DoCast(me, SPELL_PURPLE_COLORATION, true);
                me->RemoveAurasDueToSpell(SPELL_CARAPACE_CTHUN);

                scheduler.Schedule(45s, [this](TaskContext /*context*/)
                {
                    ScheduleTasks();
                    //Remove purple coloration
                    me->RemoveAurasDueToSpell(SPELL_PURPLE_COLORATION);
                    DoCastSelf(SPELL_CARAPACE_CTHUN, true);
                    //Spawn flesh tentacle
                    for (uint8 i = 0; i < 2; i++)
                    {
                        me->SummonCreature(NPC_FLESH_TENTACLE, FleshTentaclePos[i], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);
                    }
                });
            }
        }
    }

    private:
        //Out of combat whisper timer
        uint32 WisperTimer;

        //Body Phase
        uint8 _fleshTentaclesKilled;
};

struct npc_eye_tentacle : public ScriptedAI
{
    npc_eye_tentacle(Creature* creature) : ScriptedAI(creature)
    {
        if (Creature* portal = me->SummonCreature(NPC_SMALL_PORTAL, *me, TEMPSUMMON_CORPSE_DESPAWN))
        {
            portal->SetReactState(REACT_PASSIVE);
            _portalGUID = portal->GetGUID();

            if (me->ToTempSummon())
            {
                if (Unit* summoner = me->ToTempSummon()->GetSummonerUnit())
                {
                    if (Creature* creature = summoner->ToCreature())
                    {
                        creature->AI()->JustSummoned(portal);
                    }
                }
            }
        }

        me->SetCombatMovement(false);
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
        DoZoneInCombat();
        scheduler.Schedule(500ms, [this](TaskContext /*task*/)
        {
            DoCastAOE(SPELL_GROUND_RUPTURE);
        })
        .Schedule(5min, [this](TaskContext /*task*/)
        {
            me->DespawnOrUnsummon();
        });
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        scheduler.Schedule(1s, 5s, [this](TaskContext context)
        {
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, NotInStomachSelector()))
            {
                DoCast(target, SPELL_MIND_FLAY);
            }

            context.Repeat(10s, 15s);
        });
    }

    void UpdateAI(uint32 diff) override
    {
        //Check if we have a target
        if (!UpdateVictim())
            return;

        scheduler.Update(diff);
    }

private:
    ObjectGuid _portalGUID;
};

struct npc_claw_tentacle : public ScriptedAI
{
    npc_claw_tentacle(Creature* creature) : ScriptedAI(creature)
    {
        me->SetCombatMovement(false);

        if (Creature* portal = me->SummonCreature(NPC_SMALL_PORTAL, *me, TEMPSUMMON_CORPSE_DESPAWN))
        {
            portal->SetReactState(REACT_PASSIVE);
            _portalGUID = portal->GetGUID();

            if (me->ToTempSummon())
            {
                if (Unit* summoner = me->ToTempSummon()->GetSummonerUnit())
                {
                    if (Creature* creature = summoner->ToCreature())
                    {
                        creature->AI()->JustSummoned(portal);
                    }
                }
            }
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
        scheduler.Schedule(Milliseconds(500), [this](TaskContext /*task*/)
        {
            DoCastAOE(SPELL_GROUND_RUPTURE);
        }).Schedule(Minutes(5), [this](TaskContext /*task*/)
        {
            me->DespawnOrUnsummon();
        });
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        DoZoneInCombat();

        scheduler.Schedule(2s, [this](TaskContext context)
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

        scheduler.Update(diff);

        DoMeleeAttackIfReady();
    }

private:
    ObjectGuid _portalGUID;
};

struct npc_giant_claw_tentacle : public ScriptedAI
{
    npc_giant_claw_tentacle(Creature* creature) : ScriptedAI(creature)
    {
        me->SetCombatMovement(false);

        if (Creature* portal = me->SummonCreature(NPC_GIANT_PORTAL, *me, TEMPSUMMON_CORPSE_DESPAWN))
        {
            portal->SetReactState(REACT_PASSIVE);
            _portalGUID = portal->GetGUID();

            if (me->ToTempSummon())
            {
                if (Unit* summoner = me->ToTempSummon()->GetSummonerUnit())
                {
                    if (Creature* creature = summoner->ToCreature())
                    {
                        creature->AI()->JustSummoned(portal);
                    }
                }
            }
        }

        _canAttack = false;
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
        scheduler.Schedule(500ms, [this](TaskContext /*task*/)
        {
            DoCastAOE(SPELL_MASSIVE_GROUND_RUPTURE);
        });
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        DoZoneInCombat();
        ScheduleTasks();
    }

    void ScheduleTasks()
    {
        // Check if a target is in melee range
        scheduler.Schedule(10s, [this](TaskContext task)
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
            }).Schedule(2s, [this](TaskContext context)
            {
                DoCastVictim(SPELL_HAMSTRING);
                context.Repeat(10s);
            }).Schedule(5s, [this](TaskContext context)
            {
                DoCastSelf(SPELL_THRASH);
                context.Repeat(10s);
            }).Schedule(3s, [this](TaskContext /*context*/)
            {
                _canAttack = true;
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

        scheduler.CancelAll();
        _canAttack = false;

        scheduler.Schedule(5s, [this](TaskContext /*task*/)
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

            ScheduleTasks();
        }
    }

    void UpdateAI(uint32 diff) override
    {
        //Check if we have a target
        if (!UpdateVictim())
            return;

        scheduler.Update(diff);

        if (_canAttack)
        {
            DoMeleeAttackIfReady();
        }
    }

private:
    ObjectGuid _portalGUID;
    bool _canAttack;
};

struct npc_giant_eye_tentacle : public ScriptedAI
{
    npc_giant_eye_tentacle(Creature* creature) : ScriptedAI(creature)
    {
        me->SetCombatMovement(false);

        if (Creature* portal = me->SummonCreature(NPC_GIANT_PORTAL, *me, TEMPSUMMON_CORPSE_DESPAWN))
        {
            portal->SetReactState(REACT_PASSIVE);
            _portalGUID = portal->GetGUID();

            if (me->ToTempSummon())
            {
                if (Unit* summoner = me->ToTempSummon()->GetSummonerUnit())
                {
                    if (Creature* creature = summoner->ToCreature())
                    {
                        creature->AI()->JustSummoned(portal);
                    }
                }
            }
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
        scheduler.Schedule(500ms, [this](TaskContext /*task*/)
        {
            DoCastAOE(SPELL_MASSIVE_GROUND_RUPTURE);
        }).Schedule(1s, 5s, [this](TaskContext context)
        {
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, NotInStomachSelector()))
            {
                DoCast(target, SPELL_GREEN_BEAM);
            }

            context.Repeat(2100ms);
        });
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        DoZoneInCombat();
    }

    void UpdateAI(uint32 diff) override
    {
        //Check if we have a target
        if (!UpdateVictim())
            return;

        scheduler.Update(diff);
    }

private:
    ObjectGuid _portalGUID;
};

class spell_cthun_dark_glare : public SpellScript
{
    PrepareSpellScript(spell_cthun_dark_glare);

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        Unit* caster = GetCaster();
        targets.remove_if([caster](WorldObject const* target) { return !caster->HasInLine(target, 5.0f); });
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_cthun_dark_glare::FilterTargets, EFFECT_ALL, TARGET_UNIT_CONE_ENEMY_24);
    }
};

class spell_cthun_digestive_acid : public AuraScript
{
    PrepareAuraScript(spell_cthun_digestive_acid);

    void OnPeriodic(AuraEffect const* /*aurEff*/)
    {
        if (InstanceScript* instance = GetUnitOwner()->GetInstanceScript())
        {
            if (Creature* cthun = instance->GetCreature(DATA_CTHUN))
            {
                cthun->CastSpell(GetUnitOwner(), SPELL_DIGESTIVE_ACID, true);
            }
        }
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_cthun_digestive_acid::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE);
    }
};

// 4033 - At C'thun's stomach
class at_cthun_stomach_exit : public AreaTriggerScript
{
public:
    at_cthun_stomach_exit() : AreaTriggerScript("at_cthun_stomach_exit") { }

    bool OnTrigger(Player* player, AreaTrigger const* /*at*/) override
    {
        if (InstanceScript* instance = player->GetInstanceScript())
        {
            if (Creature* cthun = instance->GetCreature(DATA_CTHUN))
            {
                if (Creature* trigger = player->FindNearestCreature(NPC_TRIGGER, 15.0f))
                {
                    trigger->CastSpell(player, SPELL_EXIT_STOMACH, true);

                    if (Creature* exittrigger = player->FindNearestCreature(NPC_EXIT_TRIGGER, 15.0f))
                    {
                        exittrigger->CastSpell(player, SPELL_RUBBLE_ROCKY, true);
                    }
                }

                player->m_Events.AddEventAtOffset([player, cthun]()
                {
                    if (player->FindNearestCreature(NPC_EXIT_TRIGGER, 10.0f))
                    {
                        player->JumpTo(0.0f, 80.0f, false);

                        player->m_Events.AddEventAtOffset([player, cthun]()
                        {
                            if (cthun)
                            {
                                player->NearTeleportTo(cthun->GetPositionX(), cthun->GetPositionY(), cthun->GetPositionZ() + 10, float(rand32() % 6));
                            }

                            player->RemoveAurasDueToSpell(SPELL_DIGESTIVE_ACID);
                        }, 1s);
                    }
                    else
                    {
                        player->m_Events.KillAllEvents(false);
                    }
                }, 3s);
            }
        }

        return true;
    }
};

class at_cthun_center : public AreaTriggerScript
{
public:
    at_cthun_center() : AreaTriggerScript("at_cthun_center") { }

    bool OnTrigger(Player* player, AreaTrigger const* /*at*/) override
    {
        if (InstanceScript* instance = player->GetInstanceScript())
        {
            if (Creature* cthun = instance->GetCreature(DATA_CTHUN))
            {
                if (cthun->IsAlive())
                {
                    cthun->CastSpell(player, SPELL_SPIT_OUT, true);
                }
            }
        }

        return true;
    }
};

void AddSC_boss_cthun()
{
    RegisterTempleOfAhnQirajCreatureAI(boss_eye_of_cthun);
    RegisterTempleOfAhnQirajCreatureAI(boss_cthun);
    RegisterTempleOfAhnQirajCreatureAI(npc_eye_tentacle);
    RegisterTempleOfAhnQirajCreatureAI(npc_claw_tentacle);
    RegisterTempleOfAhnQirajCreatureAI(npc_giant_claw_tentacle);
    RegisterTempleOfAhnQirajCreatureAI(npc_giant_eye_tentacle);
    RegisterSpellScript(spell_cthun_dark_glare);
    RegisterSpellScript(spell_cthun_digestive_acid);
    new at_cthun_stomach_exit();
    new at_cthun_center();
}
