/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "CreatureScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "halls_of_stone.h"

enum NPCs
{
    NPC_DARK_RUNE_PROTECTOR         = 27983,
    NPC_DARK_RUNE_STORMCALLER       = 27984,
    NPC_IRON_GOLEM_CUSTODIAN        = 27985,
    NPC_DARK_MATTER                 = 28235,
    NPC_DARK_MATTER_TARGET          = 28237,
    NPC_SEARING_GAZE_TRIGGER        = 28265,
};

enum Misc
{
    // BRANN EVENT
    SPELL_GLARE_OF_THE_TRIBUNAL     = 50988,
    SPELL_DARK_MATTER_VISUAL        = 51000,
    SPELL_DARK_MATTER_VISUAL_CHANNEL= 51001,
    SPELL_DARK_MATTER               = 51012,
    SPELL_SEARING_GAZE              = 51136,
    SPELL_STEALTH                   = 58506,

    // Serverside
    SPELL_TRIBUNAL_CREDIT_MARKER    = 59046,

    // QUESTS
    QUEST_HALLS_OF_STONE            = 13207,
};

enum BrannMovement
{
    PATH_ESCORT            = 280701,
    PATH_SJONNIR_FIGHT     = 280702,

    POINT_TRIBUNAL_CONSOLE = 1,
    POINT_TRIBUNAL_LORE    = 2,
    POINT_TRIBUNAL_LEAVE   = 3,
    POINT_SJONNIR_DOOR     = 4,
    POINT_SJONNIR_FIGHT    = 5,
    POINT_SJONNIR_DEAD     = 6,
};

enum ContextGroups
{
    CONTEXT_GROUP_KADDRAK       = 1,
    CONTEXT_GROUP_MARNAK,
    CONTEXT_GROUP_ABEDNEUM,
    CONTEXT_GROUP_PROTECTORS,
    CONTEXT_GROUP_STORMCALLERS,
    CONTEXT_GROUP_GOLEMS,
    CONTEXT_GROUP_TRANSITION,
};

enum TalkGroups
{
    TALK_GROUP_PHASE1       = 1,
    TALK_GROUP_PHASE2,
    TALK_GROUP_PHASE3,
    TALK_GROUP_EVENT_END,
};

enum AbedneumTexts
{
    SAY_ABEDNEUM_WARNING      = 0, // Warning: life form pattern not recognized...
    SAY_ABEDNEUM_CRITICAL     = 1, // Critical threat index...
    SAY_ABEDNEUM_FAILSAFE     = 2, // Alert: security fail-safes deactivated...
    SAY_ABEDNEUM_ONLINE       = 3, // System online...
    SAY_ABEDNEUM_LORE_1       = 4, // Accessing prehistoric data...
    SAY_ABEDNEUM_LORE_2       = 5, // Accessing... In the early stages...
    SAY_ABEDNEUM_LORE_3       = 6, // Designation: Old Gods...
    SAY_ABEDNEUM_SESSION_END  = 7, // Acknowledged, Branbronzan...
};

enum KaddrakTexts
{
    SAY_KADDRAK_SECURITY  = 0, // Security breach in progress...
    SAY_KADDRAK_LORE_1    = 1, // Accessing... Creators arrived...
    SAY_KADDRAK_LORE_2    = 2, // Correct. Creators neutralized...
    SAY_KADDRAK_LORE_3    = 3, // Designations: Aesir and Vanir...
};

enum MarnakTexts
{
    SAY_MARNAK_THREAT   = 0, // Threat index threshold exceeded...
    SAY_MARNAK_LORE_1   = 1, // Additional background...
    SAY_MARNAK_LORE_2   = 2, // Unknown. Data suggests...
    SAY_MARNAK_LORE_3   = 3, // Essentially that is correct.
};

enum GossipIDs
{
    TRIBUNAL_BEFORE = 9669,
    TRIBUNAL_START  = 9670,
    TRIBUNAL_END    = 10206,
    SJONNIR_DOOR    = 10012,
    SJONNIR_END     = 9725,
};

Position brannEscortDonePoint = { 939.6467f, 375.48926f, 207.41608f, 0.f };
Position brannTribunalEventDonePoint = { 1199.685f, 667.15497f, 196.32364f, 3.124139f };
Position brannDoorDone = { 1256.33f, 667.028f, 189.59921f, 0.f };

struct brann_bronzebeard : public ScriptedAI
{
    brann_bronzebeard(Creature* creature) : ScriptedAI(creature), summons(me), _recentlySpoken(false)
    {
        instance = creature->GetInstanceScript();
    }

    void Reset() override
    {
        scheduler.CancelAll();
        me->m_Events.KillAllEvents(false);
        me->SetRegeneratingHealth(false);
        me->SetGossipMenuId(TRIBUNAL_BEFORE);
        me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);
        me->SetReactState(REACT_PASSIVE);
        summons.DespawnAll();

        // Escort to Tribunal of Ages failed, respawn at original location
        if (instance->GetBossState(BRANN_BRONZEBEARD) == IN_PROGRESS)
        {
            me->SetReactState(REACT_AGGRESSIVE);
        }

        // Respawn Handling
        if (instance->GetBossState(BRANN_DOOR) == DONE)
        {
            // Past Sjonnir's Door
            me->NearTeleportTo(brannDoorDone);
            me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);
            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_READY_UNARMED);
            me->SetImmuneToAll(true);
        }
        else if (instance->GetBossState(BOSS_TRIBUNAL_OF_AGES) == DONE)
        {
            // In front of Sjonnir's Door
            me->NearTeleportTo(brannTribunalEventDonePoint);
            me->SetGossipMenuId(SJONNIR_DOOR);
            DoCastSelf(SPELL_STEALTH);
            me->SetImmuneToAll(true);
        }
        else if (instance->GetBossState(BRANN_BRONZEBEARD) == DONE)
        {
            // Escort to Tribunal of Ages arena Finished
            me->NearTeleportTo(brannEscortDonePoint);
            me->SetGossipMenuId(TRIBUNAL_START);
        }
    }

    void sGossipSelect(Player* player, uint32 /*sender*/, uint32  /*action*/) override
    {
        me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);
        switch (me->GetGossipMenuId())
        {
        case TRIBUNAL_BEFORE:
            me->AI()->DoAction(ACTION_START_ESCORT_EVENT);
            break;
        case TRIBUNAL_START:
            me->AI()->DoAction(ACTION_START_TRIBUNAL);
            break;
        case TRIBUNAL_END:
            me->AI()->DoAction(ACTION_GO_TO_SJONNIR);
            break;
        case SJONNIR_DOOR:
            me->AI()->DoAction(ACTION_OPEN_DOOR);
            break;
        default:
            break;
        }
    }

    void DoAction(int32 action) override
    {
        switch (action)
        {
        case ACTION_START_ESCORT_EVENT: // Received via gossip
            Talk(SAY_BRANN_ESCORT_START);
            me->LoadPath(PATH_ESCORT);
            me->GetMotionMaster()->MoveWaypoint(PATH_ESCORT, false);
            me->SetReactState(REACT_AGGRESSIVE);
            me->SetImmuneToAll(true); // @TODO: He is cancelling the path when entering combat or when interacted with. Dunno fix for that yet.
            me->SetRegeneratingHealth(true);
            me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);
            instance->SetBossState(BRANN_BRONZEBEARD, IN_PROGRESS);
            break;
        case ACTION_START_TRIBUNAL: // Received via gossip
        {
            // DoCastSelf 51810 Brann Health Checker
            me->SetImmuneToAll(false); // @TODO
            me->SetReactState(REACT_PASSIVE);
            me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);
            me->GetMotionMaster()->MovePoint(POINT_TRIBUNAL_CONSOLE, 897.1759f, 331.77386f, 203.70638f);
            InitializeEvent();
            break;
        }
        case ACTION_GO_TO_SJONNIR: // Received via gossip
            me->m_Events.KillAllEvents(false);
            scheduler.CancelAll();

            Talk(SAY_BRANN_ENTRANCE_MEET);
            me->SetReactState(REACT_PASSIVE);
            me->SetRegeneratingHealth(true);

            ResetEvent();
            me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);
            DoCast(me, 58506, false);
            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_READY_UNARMED);

            me->GetMotionMaster()->MovePoint(POINT_TRIBUNAL_LEAVE, 935.955f, 371.031f, 207.41751f);
            break;
        case ACTION_OPEN_DOOR: // Reveived via gossip
            me->RemoveAura(SPELL_STEALTH);
            me->ReplaceAllNpcFlags(UNIT_NPC_FLAG_NONE);
            me->SetWalk(true);
            me->GetMotionMaster()->MovePoint(POINT_SJONNIR_DOOR, 1202.91f, 667.049f, 196.23315f);
            break;
        case ACTION_START_SJONNIR_FIGHT: // Received by Sjonnir
            me->GetMotionMaster()->MovePath(PATH_SJONNIR_FIGHT);
            break;
        case ACTION_SJONNIR_DEAD: // Received by Sjonnir
            me->m_Events.KillAllEvents(false);
            scheduler.CancelAll();
            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_STAND);
            me->ReplaceAllNpcFlags(UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);
            me->SetFacingTo(3.147235631942749023f);
            me->m_Events.AddEventAtOffset([this] {
                Talk(SAY_BRANN_VICTORY_SJONNIR_1);
            }, 10s);
            me->m_Events.AddEventAtOffset([this] {
                Talk(SAY_BRANN_VICTORY_SJONNIR_2);
            }, 22500ms);
            me->m_Events.AddEventAtOffset([this] {
                me->GetMotionMaster()->MovePoint(POINT_SJONNIR_DEAD, 1308.33f, 666.755f, 189.5994f);
            }, 23500ms);
            break;
        case ACTION_SJONNIR_WIPE_START: // Received by Sjonnir
            me->DespawnOrUnsummon(0s, 5s);
            break;
        case ACTION_PLAYER_DEATH_IN_TRIBUNAL: // Received via Instance
            if (!_recentlySpoken)
            {
                Talk(SAY_BRANN_PLAYER_DEATH);
                _recentlySpoken = true;
                me->m_Events.AddEventAtOffset([this] {
                    _recentlySpoken = false;
                }, 6s);
            }
            break;
        case ACTION_SKIP_PHASE: // Debug, received by player
            if (_currentPhase >= 1 && _currentPhase < 3)
                TransitionToPhase(_currentPhase + 1);
            else if (_currentPhase == 3)
                EndTribunalFight();
            break;
        default:
            break;
        }
    }

    void MovementInform(uint32 type, uint32 id) override
    {
        /* Movement:
        *  Path to Tribunal Start
        *  Point to Tribunal Console
        *  Point to Tribunal Lore
        *  Point to Tribunal Leave
        *  Point to Sjonnir's Door to Open
        *  Point to Sjonnir's Arena to Fight
        *  Path to Sjonnir's Console
        *  Point to Sjonnir's Console Again after his defeat
        */
        if (type == POINT_MOTION_TYPE)
        {
            switch (id)
            {
            case POINT_TRIBUNAL_CONSOLE:
                me->SetEmoteState(EMOTE_STATE_USE_STANDING);
                break;
            case POINT_TRIBUNAL_LORE:
                me->SetFacingTo(3.926990747451782226f);
                me->SetGossipMenuId(TRIBUNAL_END);
                me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);
                break;
            case POINT_TRIBUNAL_LEAVE:
                // Will respawn in front of Sjonnir's Door
                // Sniff reveals different GUID, same entry
                me->DespawnOrUnsummon(0s, 5s);
                break;
            case POINT_SJONNIR_DOOR:
                me->SetEmoteState(EMOTE_STATE_USE_STANDING);
                me->SetWalk(false);
                me->m_Events.AddEventAtOffset([&] {
                    me->SetEmoteState(EMOTE_ONESHOT_NONE);
                    instance->SetBossState(BRANN_DOOR, DONE); // Opens Door to Sjonnir
                    instance->SetData(BRANN_DOOR, DONE);
                }, 3200ms);
                me->m_Events.AddEventAtOffset([&] {
                    me->GetMotionMaster()->MovePoint(POINT_SJONNIR_FIGHT, 1256.33f, 667.028f, 189.59921);
                }, 5600ms);
                break;
            case POINT_SJONNIR_FIGHT:
                me->SetEmoteState(EMOTE_STATE_READY_UNARMED);
                Talk(SAY_BRANN_FRONT_OF_SJONNIR);
                break;
            case POINT_SJONNIR_DEAD:
                me->SetFacingTo(0.104719758033752441f);
                me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);
                me->SetGossipMenuId(SJONNIR_END);
                break;
            default:
                break;
            }
        }
    }

    void PathEndReached(uint32 pathId) override
    {
        if (pathId == PATH_ESCORT)
        {
            instance->SetBossState(BRANN_BRONZEBEARD, DONE);
            Talk(SAY_BRANN_EVENT_INTRO_1);
            me->SetReactState(REACT_PASSIVE);
            me->SetRegeneratingHealth(false);
            me->SetGossipMenuId(TRIBUNAL_START);
            me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);
        }
    }

    void EnterEvadeMode(EvadeReason why) override
    {
        if (instance->GetBossState(BRANN_BRONZEBEARD) == IN_PROGRESS)
        {
            // During escort: clear combat but don't call MoveTargetedHome(),
            // so the WaypointMovementGenerator stays active and resumes.
            _EnterEvadeMode(why);
            return;
        }
        ScriptedAI::EnterEvadeMode(why);
    }

    void JustSummoned(Creature* cr) override
    {
        if (cr->GetEntry() == NPC_ABEDNEUM || cr->GetEntry() == NPC_KADDRAK || cr->GetEntry() == NPC_MARNAK)
            cr->SetCanFly(true);
        else
            summons.Summon(cr);
    }

    void InitializeEvent()
    {
        // There are 3 phases in this event, each transition contains dialogue.
        // Each phase has one additional NPC and one head active.
        // Each phase takes approximately 100s
        instance->SetBossState(BOSS_TRIBUNAL_OF_AGES, IN_PROGRESS);

        if (Creature* cr = me->SummonCreature(NPC_KADDRAK, 928.0f, 331.276f, 219.73332f, 1.8326f, TEMPSUMMON_TIMED_DESPAWN, 580000))
            KaddrakGUID = cr->GetGUID();

        if (Creature* cr = me->SummonCreature(NPC_MARNAK, 891.309f, 359.38196f, 217.42168f, 4.6774f, TEMPSUMMON_TIMED_DESPAWN, 580000))
            MarnakGUID = cr->GetGUID();

        if (Creature* cr = me->SummonCreature(NPC_ABEDNEUM, 892.25f, 331.25f, 223.86833f, 0.68067f, TEMPSUMMON_TIMED_DESPAWN, 580000)) // Left Eye Position, actual position: 896.07965f, 330.89822f, 237.91263f, 3.5779f
            AbedneumGUID = cr->GetGUID();

        _currentPhase = 1;
        SchedulePhaseTalks(1);
        SchedulePhaseAbilities(1);
        ScheduleNextTransition();
    }

    void ResetEvent()
    {
        if (GameObject* tribunal = ObjectAccessor::GetGameObject(*me, instance->GetGuidData(GO_TRIBUNAL_CONSOLE)))
            tribunal->SetGoState(GO_STATE_READY);

        if (GameObject* tribunalSkyFloor = ObjectAccessor::GetGameObject(*me, instance->GetGuidData(GO_SKY_FLOOR)))
            tribunalSkyFloor->SetGoState(GO_STATE_READY);

        scheduler.CancelAll();
        me->m_Events.KillAllEvents(false);
        summons.DespawnAll();
        DespawnHeads();

        _currentPhase = 0;
    }

    void SwitchHeadVisual(uint8 headMask, bool activate)
    {
        if (!instance)
            return;

        GameObject* go = nullptr;
        if (headMask & 0x1) // Kaddrak
            if ((go = me->GetMap()->GetGameObject(instance->GetGuidData(GO_KADDRAK))))
            {
                if (activate)
                {
                    go->SendCustomAnim(0);
                }
                else
                {
                    go->SendCustomAnim(1);
                    if (go->GetGoState() == GO_STATE_ACTIVE)
                        go->SetGoState(GO_STATE_READY);
                }
            }
        if (headMask & 0x2) // Marnak
            if ((go = me->GetMap()->GetGameObject(instance->GetGuidData(GO_MARNAK))))
            {
                if (activate)
                {
                    go->SendCustomAnim(0);
                }
                else
                {
                    go->SendCustomAnim(1);
                    if (go->GetGoState() == GO_STATE_ACTIVE)
                        go->SetGoState(GO_STATE_READY);
                }
            }
        if (headMask & 0x4) // Abedneum
            if ((go = me->GetMap()->GetGameObject(instance->GetGuidData(GO_ABEDNEUM))))
            {
                if (activate)
                {
                    go->SendCustomAnim(0);
                }
                else
                {
                    go->SendCustomAnim(1);
                    if (go->GetGoState() == GO_STATE_ACTIVE)
                        go->SetGoState(GO_STATE_READY);
                }
            }
    }

    Creature* GetAbedneum() { return ObjectAccessor::GetCreature(*me, AbedneumGUID); }
    Creature* GetMarnak() { return ObjectAccessor::GetCreature(*me, MarnakGUID); }
    Creature* GetKaddrak() { return ObjectAccessor::GetCreature(*me, KaddrakGUID); }

    void DespawnHeads()
    {
        Creature* cr;
        if ((cr = GetAbedneum())) cr->DespawnOrUnsummon();
        if ((cr = GetMarnak())) cr->DespawnOrUnsummon();
        if ((cr = GetKaddrak())) cr->DespawnOrUnsummon();

        SwitchHeadVisual(0x7, false);
    }

    void SummonCreatures(uint32 entry)
    {
        switch (entry)
        {
        case NPC_DARK_RUNE_PROTECTOR:
            me->SummonCreatureGroup(0);
            break;
        case NPC_DARK_RUNE_STORMCALLER:
            me->SummonCreatureGroup(1);
            break;
        case NPC_IRON_GOLEM_CUSTODIAN:
            me->SummonCreatureGroup(2);
            break;
        }
    }

    void TransitionToPhase(uint8 phase)
    {
        _currentPhase = phase;
        me->m_Events.CancelEventGroup(phase - 1); // Cancel previous phase's remaining talks
        SchedulePhaseTalks(phase);
        SchedulePhaseAbilities(phase);
        ScheduleNextTransition();
    }

    void ScheduleNextTransition()
    {
        scheduler.CancelGroup(CONTEXT_GROUP_TRANSITION);
        switch (_currentPhase)
        {
        case 1:
            scheduler.Schedule(100s, CONTEXT_GROUP_TRANSITION, [this](TaskContext) {
                TransitionToPhase(2);
            });
            break;
        case 2:
            scheduler.Schedule(100s, CONTEXT_GROUP_TRANSITION, [this](TaskContext) {
                TransitionToPhase(3);
            });
            break;
        case 3:
            scheduler.Schedule(100s, CONTEXT_GROUP_TRANSITION, [this](TaskContext) {
                EndTribunalFight();
            });
            break;
        default:
            break;
        }
    }

    void SchedulePhaseTalks(uint8 phase)
    {
        switch (phase)
        {
        case 1:
            me->m_Events.AddEventAtOffset([this] {
                Talk(SAY_BRANN_EVENT_INTRO_2);
            }, 0ms, TALK_GROUP_PHASE1);

            me->m_Events.AddEventAtOffset([this] {
                if (Creature* abedneum = GetAbedneum())
                    abedneum->AI()->Talk(SAY_ABEDNEUM_WARNING);
            }, 12500ms, TALK_GROUP_PHASE1);

            me->m_Events.AddEventAtOffset([this] {
                Talk(SAY_BRANN_EVENT_A_1);
            }, 23500ms, TALK_GROUP_PHASE1);

            me->m_Events.AddEventAtOffset([this] {
                if (Creature* kaddrak = GetKaddrak())
                    kaddrak->AI()->Talk(SAY_KADDRAK_SECURITY);
            }, 29500ms, TALK_GROUP_PHASE1);

            me->m_Events.AddEventAtOffset([this] {
                Talk(SAY_BRANN_EVENT_A_3);
            }, 41500ms, TALK_GROUP_PHASE1);

            break;
        case 2:
            me->m_Events.AddEventAtOffset([this] {
                Talk(SAY_BRANN_EVENT_B_1);
            }, 0ms, TALK_GROUP_PHASE2);

            me->m_Events.AddEventAtOffset([this] {
                if (Creature* marnak = GetMarnak())
                    marnak->AI()->Talk(SAY_MARNAK_THREAT);
            }, 3s, TALK_GROUP_PHASE2);

            me->m_Events.AddEventAtOffset([this] {
                Talk(SAY_BRANN_EVENT_B_3);
            }, 11s, TALK_GROUP_PHASE2);

            break;
        case 3:
            me->m_Events.AddEventAtOffset([this] {
                Talk(SAY_BRANN_EVENT_C_1);
            }, 0ms, TALK_GROUP_PHASE3);

            me->m_Events.AddEventAtOffset([this] {
                if (Creature* abedneum = GetAbedneum())
                    abedneum->AI()->Talk(SAY_ABEDNEUM_CRITICAL);
            }, 5s, TALK_GROUP_PHASE3);

            me->m_Events.AddEventAtOffset([this] {
                Talk(SAY_BRANN_EVENT_C_3);
            }, 12s, TALK_GROUP_PHASE3);

            break;
        }
    }

    void SchedulePhaseAbilities(uint8 phase)
    {
        switch (phase)
        {
        case 1:
            // Kaddrak head visual activates
            scheduler.Schedule(30s, [this](TaskContext) {
                SwitchHeadVisual(0x1, true);
            });
            // Kaddrak glare of the tribunal
            scheduler.Schedule(47s, [this](TaskContext context) {
                if (Creature* kaddrak = GetKaddrak())
                    if (Player* plr = SelectTargetFromPlayerList(100.0f))
                        kaddrak->CastSpell(plr, SPELL_GLARE_OF_THE_TRIBUNAL, true);
                // Alternate eye position 1s after each glare
                scheduler.Schedule(1s, [this](TaskContext) {
                    if (Creature* kaddrak = GetKaddrak())
                    {
                        if (_leftEye)
                            kaddrak->UpdatePosition(923.5f, 326.358f, 219.73332f, 2.28638f, true);
                        else
                            kaddrak->UpdatePosition(928.f, 331.276f, 219.73332f, 1.83259f, true);
                        _leftEye = !_leftEye;
                        kaddrak->StopMovingOnCurrentPos();
                    }
                });
                context.SetGroup(CONTEXT_GROUP_KADDRAK);
                context.Repeat(1500ms);
            });
            // Protector spawning
            scheduler.Schedule(52s, [this](TaskContext context) {
                SummonCreatures(NPC_DARK_RUNE_PROTECTOR);
                context.SetGroup(CONTEXT_GROUP_PROTECTORS);
                context.Repeat(me->GetMap()->IsHeroic() ? 23500ms : 32500ms);
            });
            break;
        case 2:
            // Marnak head visual activates
            scheduler.Schedule(3s, [this](TaskContext) {
                SwitchHeadVisual(0x2, true);
            });
            // Marnak dark matter
            scheduler.Schedule(13s, [this](TaskContext context) {
                DoMarnakDarkMatter();
                context.SetGroup(CONTEXT_GROUP_MARNAK);
                context.Repeat(30s);
            });
            // Stormcaller spawning
            scheduler.Schedule(20s, [this](TaskContext context) {
                SummonCreatures(NPC_DARK_RUNE_STORMCALLER);
                context.SetGroup(CONTEXT_GROUP_STORMCALLERS);
                context.Repeat(me->GetMap()->IsHeroic() ? 32s : 41500ms);
            });
            break;
        case 3:
            // Abedneum head visual activates
            scheduler.Schedule(6s, [this](TaskContext) {
                SwitchHeadVisual(0x4, true);
            });
            // Abedneum searing gaze
            scheduler.Schedule(16s, [this](TaskContext context) {
                DoAbedneumSearingGaze();
                context.SetGroup(CONTEXT_GROUP_ABEDNEUM);
                context.Repeat(15s);
            });
            // Golem spawning
            scheduler.Schedule(27s, [this](TaskContext context) {
                SummonCreatures(NPC_IRON_GOLEM_CUSTODIAN);
                context.SetGroup(CONTEXT_GROUP_GOLEMS);
                context.Repeat(me->GetMap()->IsHeroic() ? 32s : 45s);
            });
            break;
        }
    }

    void EndTribunalFight()
    {
        // Stop all combat abilities and spawning
        scheduler.CancelAll();

        // Schedule end sequence talks
        me->m_Events.AddEventAtOffset([this] {
            Talk(SAY_BRANN_EVENT_D_1);
        }, 0ms, TALK_GROUP_EVENT_END);
        me->m_Events.AddEventAtOffset([this] {
            if (Creature* abedneum = GetAbedneum())
                abedneum->AI()->Talk(SAY_ABEDNEUM_FAILSAFE);
        }, 5s, TALK_GROUP_EVENT_END);
        me->m_Events.AddEventAtOffset([this] {
            Talk(SAY_BRANN_EVENT_D_3);
        }, 11s, TALK_GROUP_EVENT_END);

        me->m_Events.AddEventAtOffset([this] {
            // Fight complete - system online
            if (Creature* abedneum = GetAbedneum())
                abedneum->AI()->Talk(SAY_ABEDNEUM_ONLINE);

            summons.DespawnAll();
            me->GetMotionMaster()->MovePoint(POINT_TRIBUNAL_LORE, 917.253f, 351.925f, 203.69878f);
            instance->SetBossState(BOSS_TRIBUNAL_OF_AGES, DONE);
            me->CastSpell(me, SPELL_TRIBUNAL_CREDIT_MARKER, true);

            // Spawn chest
            if (Player* plr = SelectTargetFromPlayerList(200.0f))
            {
                if (GameObject* go = plr->SummonGameObject(
                    (me->GetMap()->IsHeroic() ? GO_TRIBUNAL_CHEST_H : GO_TRIBUNAL_CHEST),
                    880.406f, 345.164f, 203.706f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0))
                {
                    plr->RemoveGameObject(go, false);
                    go->SetLootMode(1);
                    go->ReplaceAllGameObjectFlags((GameObjectFlags)0);
                }
                plr->GroupEventHappens(QUEST_HALLS_OF_STONE, me);
            }

            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_STAND);
        }, 17s, TALK_GROUP_EVENT_END);

        // Post-fight lore conversation
        SchedulePostFightConversation();
    }

    void SchedulePostFightConversation()
    {
        // Offsets from the end of the fight (relative to EndTribunalFight call)
        me->m_Events.AddEventAtOffset([this] {
            Talk(SAY_BRANN_EVENT_END_01);
            instance->SetData(BOSS_TRIBUNAL_OF_AGES, SPECIAL); // Sky floor
        }, 25s, TALK_GROUP_EVENT_END);

        me->m_Events.AddEventAtOffset([this] {
            Talk(SAY_BRANN_EVENT_END_02);
        }, 31s, TALK_GROUP_EVENT_END);

        me->m_Events.AddEventAtOffset([this] {
            if (Creature* abedneum = GetAbedneum())
                abedneum->AI()->Talk(SAY_ABEDNEUM_LORE_1);
        }, 36s, TALK_GROUP_EVENT_END);

        me->m_Events.AddEventAtOffset([this] {
            Talk(SAY_BRANN_EVENT_END_04);
        }, 43s, TALK_GROUP_EVENT_END);

        me->m_Events.AddEventAtOffset([this] {
            if (Creature* abedneum = GetAbedneum())
                abedneum->AI()->Talk(SAY_ABEDNEUM_LORE_2);
        }, 55s, TALK_GROUP_EVENT_END);

        me->m_Events.AddEventAtOffset([this] {
            Talk(SAY_BRANN_EVENT_END_06);
        }, 67s, TALK_GROUP_EVENT_END);

        me->m_Events.AddEventAtOffset([this] {
            if (Creature* abedneum = GetAbedneum())
                abedneum->AI()->Talk(SAY_ABEDNEUM_LORE_3);
        }, 72s, TALK_GROUP_EVENT_END);

        me->m_Events.AddEventAtOffset([this] {
            Talk(SAY_BRANN_EVENT_END_08);
            instance->SetData(BOSS_TRIBUNAL_OF_AGES, DONE); // Head switch
        }, 95s, TALK_GROUP_EVENT_END);

        me->m_Events.AddEventAtOffset([this] {
            if (Creature* kaddrak = GetKaddrak())
                kaddrak->AI()->Talk(SAY_KADDRAK_LORE_1);
        }, 102s, TALK_GROUP_EVENT_END);

        me->m_Events.AddEventAtOffset([this] {
            Talk(SAY_BRANN_EVENT_END_10);
            instance->SetData(BOSS_TRIBUNAL_OF_AGES, SPECIAL);
        }, 119s, TALK_GROUP_EVENT_END);

        me->m_Events.AddEventAtOffset([this] {
            if (Creature* kaddrak = GetKaddrak())
                kaddrak->AI()->Talk(SAY_KADDRAK_LORE_2);
            instance->SetData(BOSS_TRIBUNAL_OF_AGES, DONE);
        }, 126s, TALK_GROUP_EVENT_END);

        me->m_Events.AddEventAtOffset([this] {
            Talk(SAY_BRANN_EVENT_END_12);
        }, 145s, TALK_GROUP_EVENT_END);

        me->m_Events.AddEventAtOffset([this] {
            if (Creature* kaddrak = GetKaddrak())
                kaddrak->AI()->Talk(SAY_KADDRAK_LORE_3);
        }, 148s, TALK_GROUP_EVENT_END);

        me->m_Events.AddEventAtOffset([this] {
            Talk(SAY_BRANN_EVENT_END_14);
            instance->SetData(BOSS_TRIBUNAL_OF_AGES, SPECIAL);
        }, 167s, TALK_GROUP_EVENT_END);

        me->m_Events.AddEventAtOffset([this] {
            if (Creature* marnak = GetMarnak())
                marnak->AI()->Talk(SAY_MARNAK_LORE_1);
            instance->SetData(BOSS_TRIBUNAL_OF_AGES, DONE);
        }, 178s, TALK_GROUP_EVENT_END);

        me->m_Events.AddEventAtOffset([this] {
            Talk(SAY_BRANN_EVENT_END_16);
        }, 184s, TALK_GROUP_EVENT_END);

        me->m_Events.AddEventAtOffset([this] {
            if (Creature* marnak = GetMarnak())
                marnak->AI()->Talk(SAY_MARNAK_LORE_2);
        }, 190s, TALK_GROUP_EVENT_END);

        me->m_Events.AddEventAtOffset([this] {
            Talk(SAY_BRANN_EVENT_END_18);
            instance->SetData(BOSS_TRIBUNAL_OF_AGES, SPECIAL);
        }, 214s, TALK_GROUP_EVENT_END);

        me->m_Events.AddEventAtOffset([this] {
            if (Creature* marnak = GetMarnak())
                marnak->AI()->Talk(SAY_MARNAK_LORE_3);
            instance->SetData(BOSS_TRIBUNAL_OF_AGES, DONE);
        }, 238s, TALK_GROUP_EVENT_END);

        me->m_Events.AddEventAtOffset([this] {
            Talk(SAY_BRANN_EVENT_END_20);
        }, 240s, TALK_GROUP_EVENT_END);

        me->m_Events.AddEventAtOffset([this] {
            if (Creature* abedneum = GetAbedneum())
                abedneum->AI()->Talk(SAY_ABEDNEUM_SESSION_END);
            instance->SetData(BOSS_TRIBUNAL_OF_AGES, SPECIAL);
        }, 249s, TALK_GROUP_EVENT_END);

        // Gossip to go to Sjonnir or auto-transition
        me->m_Events.AddEventAtOffset([this] {
            Talk(SAY_BRANN_ENTRANCE_MEET);
        }, 256s, TALK_GROUP_EVENT_END);
    }

    void DoMarnakDarkMatter()
    {
        Creature* marnak = GetMarnak();
        if (!marnak)
            return;

        Creature* target = me->SummonCreature(NPC_DARK_MATTER_TARGET, 899.843f, 355.271f, 214.301f, 0, TEMPSUMMON_TIMED_DESPAWN, 10000);
        if (!target)
            return;

        target->SetCanFly(true);
        darkMatterTargetGUID = target->GetGUID();

        // Right eye visual
        if (Creature* cra = me->SummonCreature(NPC_DARK_MATTER, 891.30902f, 359.38195f, 217.421676f + 2.f /* +2 hacked: too low otherwise */, 4.67748f, TEMPSUMMON_TIMED_DESPAWN, 5000))
            cra->CastSpell(cra, SPELL_DARK_MATTER_VISUAL_CHANNEL, false);

        // Left eye visual
        if (Creature* crb = me->SummonCreature(NPC_DARK_MATTER, 895.93292f, 363.52789f, 219.33831f, 5.58505f, TEMPSUMMON_TIMED_DESPAWN, 5000))
            crb->CastSpell(crb, SPELL_DARK_MATTER_VISUAL_CHANNEL, false);

        // After 5s, start chasing player
        me->m_Events.AddEventAtOffset([this] {
            Creature* darkMatterTarget = ObjectAccessor::GetCreature(*me, darkMatterTargetGUID);
            if (!darkMatterTarget)
                return;

            darkMatterTarget->CastSpell(darkMatterTarget, SPELL_DARK_MATTER_VISUAL, false);
            Player* plr = SelectTargetFromPlayerList(100.0f);
            if (!plr)
                return;

            darkMatterTarget->GetMotionMaster()->MovePoint(0, plr->GetPositionX(), plr->GetPositionY(), plr->GetPositionZ());

            Milliseconds delay;
            if (darkMatterTarget->GetDistance(plr) < 5.0f)
                delay = 3s;
            else if (darkMatterTarget->GetDistance(plr) < 30.0f)
                delay = 3500ms;
            else
                delay = 4500ms;

            // After reaching player, explode
            me->m_Events.AddEventAtOffset([this] {
                if (Creature* dm = ObjectAccessor::GetCreature(*me, darkMatterTargetGUID))
                {
                    dm->CastSpell(dm, SPELL_DARK_MATTER, true);
                    dm->DespawnOrUnsummon(500ms);
                }
            }, delay);
        }, 5s);
    }

    void DoAbedneumSearingGaze()
    {
        if (!GetAbedneum())
            return;

        Player* plr = SelectTargetFromPlayerList(100.0f);
        if (!plr)
            return;

        if (Creature* cr = me->SummonCreature(NPC_SEARING_GAZE_TRIGGER, plr->GetPositionX(), plr->GetPositionY(), plr->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN, 10000))
        {
            me->SummonCreature(NPC_ABEDNEUM, 892.25f, 331.25f, 223.86833f, 0.68067f, TEMPSUMMON_TIMED_DESPAWN, 12000); // Left Eye
            me->SummonCreature(NPC_ABEDNEUM, 896.5f, 327.f, 223.86805f, 0.645771f, TEMPSUMMON_TIMED_DESPAWN, 12000); // Right Eye
            cr->CastSpell(cr, SPELL_SEARING_GAZE, true);
        }
    }

    void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
    {
        if (damage && instance)
            instance->SetData(DATA_BRANN_ACHIEVEMENT, false);
    }

    void JustDied(Unit* /*killer*/) override
    {
        Talk(SAY_BRANN_DEATH);
        ResetEvent();
        me->DespawnOrUnsummon(5s, 10s);

        if (instance->GetBossState(BOSS_TRIBUNAL_OF_AGES) == IN_PROGRESS)
        {
            instance->SetData(BOSS_TRIBUNAL_OF_AGES, NOT_STARTED);
        }
    }

    void UpdateAI(uint32 diff) override
    {
        scheduler.Update(diff);
    }

private:
    InstanceScript* instance;
    SummonList summons;
    ObjectGuid AbedneumGUID;
    ObjectGuid MarnakGUID;
    ObjectGuid KaddrakGUID;
    ObjectGuid darkMatterTargetGUID;
    bool _recentlySpoken;
    bool _leftEye = true;
    uint8 _currentPhase = 0;
};


// 51774 - Taunt
class spell_taunt_brann : public SpellScript
{
    PrepareSpellScript(spell_taunt_brann);

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        Unit* target = GetHitUnit();
        if (!caster || !target)
            return;

        uint32 spellId = GetEffectValue(); // 51775
        target->CastSpell(caster, spellId, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_taunt_brann::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_hos_dark_matter : public AuraScript
{
    PrepareAuraScript(spell_hos_dark_matter);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_DARK_MATTER });
    }

    void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* caster = GetCaster())
            caster->CastSpell(caster, SPELL_DARK_MATTER, true);
    }

    void Register() override
    {
        OnEffectRemove += AuraEffectRemoveFn(spell_hos_dark_matter::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_hos_dark_matter_size : public SpellScript
{
    PrepareSpellScript(spell_hos_dark_matter_size);

    void HandleApplyTouch()
    {
        if (Unit* target = GetHitUnit())
            target->SetObjectScale(0.35f);
    }

    void Register() override
    {
        AfterHit += SpellHitFn(spell_hos_dark_matter_size::HandleApplyTouch);
    }
};

void AddSC_brann_bronzebeard()
{
    RegisterCreatureAI(brann_bronzebeard);
    RegisterSpellScript(spell_hos_dark_matter);
    RegisterSpellScript(spell_hos_dark_matter_size);
    RegisterSpellScript(spell_taunt_brann);
}
