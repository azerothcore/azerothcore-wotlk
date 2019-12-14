/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ObjectMgr.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "Spell.h"
#include "SpellAuraEffects.h"
#include "GridNotifiers.h"
#include "icecrown_citadel.h"

enum Texts
{
    SAY_AGGRO                   = 0,
    SAY_VAMPIRIC_BITE           = 1,
    SAY_MIND_CONTROL            = 2,
    EMOTE_BLOODTHIRST           = 3,
    SAY_SWARMING_SHADOWS        = 4,
    EMOTE_SWARMING_SHADOWS      = 5,
    SAY_PACT_OF_THE_DARKFALLEN  = 6,
    SAY_AIR_PHASE               = 7,
    SAY_KILL                    = 8,
    SAY_WIPE                    = 9,
    SAY_BERSERK                 = 10,
    SAY_DEATH                   = 11,
    EMOTE_BERSERK_RAID          = 12
};

enum Spells
{
    SPELL_SHROUD_OF_SORROW                  = 70986,
    SPELL_FRENZIED_BLOODTHIRST_VISUAL       = 71949,
    SPELL_VAMPIRIC_BITE                     = 71726,
    SPELL_VAMPIRIC_BITE_DUMMY               = 71837,
    SPELL_ESSENCE_OF_THE_BLOOD_QUEEN_PLR    = 70879,
    SPELL_ESSENCE_OF_THE_BLOOD_QUEEN_HEAL   = 70872,
    SPELL_FRENZIED_BLOODTHIRST              = 70877,
    SPELL_UNCONTROLLABLE_FRENZY             = 70923,
    SPELL_PRESENCE_OF_THE_DARKFALLEN_DUMMY  = 70994,
    SPELL_PRESENCE_OF_THE_DARKFALLEN_EFFECT = 70995,
    SPELL_PRESENCE_OF_THE_DARKFALLEN_SE     = 71952,
    SPELL_BLOOD_MIRROR_DAMAGE               = 70821,
    SPELL_BLOOD_MIRROR_VISUAL               = 71510,
    SPELL_BLOOD_MIRROR_DUMMY                = 70838,
    SPELL_DELIRIOUS_SLASH                   = 71623,
    SPELL_PACT_OF_THE_DARKFALLEN_TARGET     = 71336,
    SPELL_PACT_OF_THE_DARKFALLEN            = 71340,
    SPELL_PACT_OF_THE_DARKFALLEN_DAMAGE     = 71341,
    SPELL_SWARMING_SHADOWS                  = 71264,
    SPELL_TWILIGHT_BLOODBOLT_TARGET         = 71445,
    SPELL_TWILIGHT_BLOODBOLT                = 71818,
    SPELL_TWILIGHT_BLOODBOLT_FROM_WHIRL     = 71446,
    SPELL_INCITE_TERROR                     = 73070,
    SPELL_BLOODBOLT_WHIRL                   = 71772,
    SPELL_ANNIHILATE                        = 71322,
};

enum Shadowmourne
{
    QUEST_BLOOD_INFUSION                    = 24756,
    SPELL_BLOOD_INFUSION_CREDIT             = 72934,
    SPELL_GUSHING_WOUND                     = 72132,
    SPELL_THIRST_QUENCHED                   = 72154,
};

#define ESSENCE_OF_BLOOD_QUEEN     RAID_MODE<uint32>(70867, 71473, 71532, 71533)
#define ESSENCE_OF_BLOOD_QUEEN_PLR RAID_MODE<uint32>(70879, 71525, 71530, 71531)
#define FRENZIED_BLOODTHIRST       RAID_MODE<uint32>(70877, 71474, 70877, 71474)
#define DELIRIOUS_SLASH            RAID_MODE<uint32>(71623, 71624, 71625, 71626)
#define PRESENCE_OF_THE_DARKFALLEN RAID_MODE<uint32>(70994, 71962, 71963, 71964)

uint32 const vampireAuras[3][MAX_DIFFICULTY] =
{
    {70867, 71473, 71532, 71533},
    {70879, 71525, 71530, 71531},
    {70877, 71474, 70877, 71474},
};

bool IsVampire(Unit const* unit)
{
    uint8 spawnMode = unit->GetMap()->GetSpawnMode();
    for (uint8 i = 0; i < 3; ++i)
        if (unit->HasAura(vampireAuras[i][spawnMode]))
            return true;
    return false;
}

enum Events
{
    EVENT_NONE,
    EVENT_BERSERK,
    EVENT_VAMPIRIC_BITE,
    EVENT_BLOOD_MIRROR,
    EVENT_DELIRIOUS_SLASH,
    EVENT_PACT_OF_THE_DARKFALLEN,
    EVENT_SWARMING_SHADOWS,
    EVENT_TWILIGHT_BLOODBOLT,
    EVENT_AIR_PHASE,
    EVENT_AIR_START_FLYING,
    EVENT_AIR_FLY_DOWN,
};

enum Guids
{
    GUID_VAMPIRE    = 1,
    GUID_BLOODBOLT  = 2,
};

enum Points
{
    POINT_CENTER    = 1,
    POINT_AIR       = 2,
    POINT_GROUND    = 3,
    POINT_MINCHAR   = 4,
};

Position const centerPos  = {4595.7090f, 2769.4190f, 400.6368f, 0.000000f};
Position const airPos     = {4595.7090f, 2769.4190f, 422.3893f, 0.000000f};
Position const mincharPos = {4629.3711f, 2782.6089f, 424.6390f, 0.000000f};

class boss_blood_queen_lana_thel : public CreatureScript
{
    public:
        boss_blood_queen_lana_thel() : CreatureScript("boss_blood_queen_lana_thel") { }

        struct boss_blood_queen_lana_thelAI : public BossAI
        {
            boss_blood_queen_lana_thelAI(Creature* creature) : BossAI(creature, DATA_BLOOD_QUEEN_LANA_THEL)
            {
                bEnteredCombat = false;
            }

            bool _creditBloodQuickening;
            bool _killMinchar;
            uint64 _tankGUID;
            uint64 _offtankGUID;
            std::set<uint64> _bloodboltedPlayers;
            std::set<uint64> _vampires;
            bool bEnteredCombat; // needed for failing an attempt in JustReachedHome()

            void Reset()
            {
                _creditBloodQuickening = false;
                _killMinchar = false;
                _tankGUID = 0;
                _offtankGUID = 0;
                _vampires.clear();
                CleanAuras();
                me->SetReactState(REACT_AGGRESSIVE);

                events.Reset();
                summons.DespawnAll();
                if (instance->GetBossState(DATA_BLOOD_QUEEN_LANA_THEL) != DONE)
                    instance->SetBossState(DATA_BLOOD_QUEEN_LANA_THEL, NOT_STARTED);
            }

            void EnterCombat(Unit* who)
            {
                if (!instance->CheckRequiredBosses(DATA_BLOOD_QUEEN_LANA_THEL, who->ToPlayer()) || !me->IsVisible())
                {
                    EnterEvadeMode();
                    instance->DoCastSpellOnPlayers(LIGHT_S_HAMMER_TELEPORT);
                    return;
                }

                bEnteredCombat = true;
                me->CastSpell(me, SPELL_SHROUD_OF_SORROW, true);
                me->CastSpell(me, SPELL_FRENZIED_BLOODTHIRST_VISUAL, true);
                events.Reset();
                events.ScheduleEvent(EVENT_BERSERK, 330000);
                events.ScheduleEvent(EVENT_VAMPIRIC_BITE, 15000);
                events.ScheduleEvent(EVENT_BLOOD_MIRROR, 2500);
                events.ScheduleEvent(EVENT_DELIRIOUS_SLASH, urand(10000, 12000));
                events.ScheduleEvent(EVENT_PACT_OF_THE_DARKFALLEN, 20000);
                events.ScheduleEvent(EVENT_SWARMING_SHADOWS, 30000);
                events.ScheduleEvent(EVENT_TWILIGHT_BLOODBOLT, urand(15000, 25000));
                events.ScheduleEvent(EVENT_AIR_PHASE, 124000 + uint32(Is25ManRaid() ? 3000 : 0));

                CleanAuras();
                me->setActive(true);
                DoZoneInCombat();
                Talk(SAY_AGGRO);
                if (instance->GetBossState(DATA_BLOOD_QUEEN_LANA_THEL) != DONE)
                    instance->SetBossState(DATA_BLOOD_QUEEN_LANA_THEL, IN_PROGRESS);
                _creditBloodQuickening = instance->GetData(DATA_BLOOD_QUICKENING_STATE) == IN_PROGRESS;
            }

            void JustDied(Unit*  /*killer*/)
            {
                _JustDied();
                Talk(SAY_DEATH);

                if (Is25ManRaid() && me->HasAura(SPELL_SHADOWS_FATE))
                    DoCastAOE(SPELL_BLOOD_INFUSION_CREDIT, true);

                CleanAuras();

                if (_creditBloodQuickening)
                {
                    instance->SetData(DATA_BLOOD_QUICKENING_STATE, DONE);
                    Map::PlayerList const& pl = me->GetMap()->GetPlayers();
                    for (Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr)
                        if (Player* p = itr->GetSource())
                            p->KilledMonsterCredit(RAID_MODE(NPC_INFILTRATOR_MINCHAR_BQ, NPC_BLOOD_QUICKENING_CREDIT_25), 0);
                    if (Creature* minchar = me->FindNearestCreature(NPC_INFILTRATOR_MINCHAR_BQ, 200.0f))
                    {
                        minchar->SetUInt32Value(UNIT_NPC_EMOTESTATE, 0);
                        minchar->SetCanFly(false);
                        minchar->SetDisableGravity(false);
                        minchar->SetHover(false);
                        minchar->RemoveAllAuras();
                        minchar->GetMotionMaster()->MoveCharge(4629.3711f, 2782.6089f, 401.5301f, SPEED_CHARGE/3.0f);
                    }
                }
            }

            void GoToMinchar()
            {
                if (!me->IsAlive())
                    return;
                instance->SetData(DATA_BLOOD_QUICKENING_STATE, DONE);
                me->AddUnitState(UNIT_STATE_EVADE);
                me->SendMeleeAttackStop(me->GetVictim());
                me->GetMotionMaster()->MoveIdle();
                me->StopMoving();
                me->SetCanFly(true);
                me->SetDisableGravity(true);
                me->SetHover(true);
                me->SendMovementFlagUpdate();
                me->GetMotionMaster()->MovePoint(POINT_MINCHAR, mincharPos);
            }

            void DoAction(int32 action)
            {
                if (action != ACTION_KILL_MINCHAR)
                    return;

                if (instance->GetBossState(DATA_BLOOD_QUEEN_LANA_THEL) == IN_PROGRESS)
                    _killMinchar = true;
                else
                    GoToMinchar();
            }

            void JustReachedHome()
            {
                me->SetCanFly(false);
                me->SetDisableGravity(false);
                me->SetHover(false);

                _JustReachedHome();
                if (bEnteredCombat)
                {
                    bEnteredCombat = false;
                    if (me->IsAlive() && instance->GetBossState(DATA_BLOOD_QUEEN_LANA_THEL) != DONE)
                        instance->SetBossState(DATA_BLOOD_QUEEN_LANA_THEL, FAIL);
                }
            }

            void KilledUnit(Unit* victim)
            {
                if (victim->GetTypeId() == TYPEID_PLAYER)
                    Talk(SAY_KILL);
            }

            void MovementInform(uint32 type, uint32 id)
            {
                if (type != EFFECT_MOTION_TYPE && type != POINT_MOTION_TYPE)
                    return;

                switch (id)
                {
                    case POINT_CENTER:
                        me->CastSpell(me, SPELL_INCITE_TERROR, false);
                        events.ScheduleEvent(EVENT_AIR_PHASE, 100000 + uint32(Is25ManRaid() ? 0 : 20000));
                        events.ScheduleEvent(EVENT_AIR_START_FLYING, 2500);
                        break;
                    case POINT_AIR:
                        _bloodboltedPlayers.clear();
                        me->CastSpell(me, SPELL_BLOODBOLT_WHIRL, false);
                        Talk(SAY_AIR_PHASE);
                        events.ScheduleEvent(EVENT_AIR_FLY_DOWN, 7000);
                        break;
                    case POINT_GROUND:
                        me->SetCanFly(false);
                        me->SetDisableGravity(false);
                        me->SetHover(false);
                        me->SetReactState(REACT_AGGRESSIVE);
                        if (Unit* target = me->SelectVictim())
                            AttackStart(target);
                        events.RescheduleEvent(EVENT_PACT_OF_THE_DARKFALLEN, 5000);
                        events.RescheduleEvent(EVENT_SWARMING_SHADOWS, 20000);
                        break;
                    case POINT_MINCHAR:
                        me->CastSpell(me, SPELL_ANNIHILATE, true);
                        me->GetMotionMaster()->MoveTargetedHome();
                        Reset();
                    default:
                        break;
                }
            }

            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim() || !CheckInRoom())
                    return;

                events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                switch (events.ExecuteEvent())
                {
                    case EVENT_BERSERK:
                        Talk(EMOTE_BERSERK_RAID);
                        Talk(SAY_BERSERK);
                        me->CastSpell(me, SPELL_BERSERK, true);
                        break;
                    case EVENT_VAMPIRIC_BITE:
                        {
                            Player* target = NULL;
                            float maxThreat = 0.0f;
                            const Map::PlayerList &pl = me->GetMap()->GetPlayers();
                            for (Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr)
                                if (Player* p = itr->GetSource())
                                    if (p->IsAlive() && p != me->GetVictim() && p->GetGUID() != _offtankGUID && !p->IsGameMaster() && p->GetDistance(me) < 70.0f)
                                    {
                                        float th = me->getThreatManager().getThreatWithoutTemp(p);
                                        if (!target || th > maxThreat)
                                        {
                                            target = p;
                                            maxThreat = th;
                                        }
                                    }

                            if (target)
                            {
                                me->CastSpell(target, SPELL_VAMPIRIC_BITE, false);
                                me->CastSpell((Unit*)NULL, SPELL_VAMPIRIC_BITE_DUMMY, true);
                                Talk(SAY_VAMPIRIC_BITE);
                                SetGUID(target->GetGUID(), GUID_VAMPIRE);
                                target->CastSpell(target, SPELL_PRESENCE_OF_THE_DARKFALLEN_DUMMY, TRIGGERED_FULL_MASK);
                                target->CastSpell(target, SPELL_PRESENCE_OF_THE_DARKFALLEN_SE, TRIGGERED_FULL_MASK);
                            }
                        }
                        break;
                    case EVENT_BLOOD_MIRROR:
                        if (me->GetVictim())
                        {
                            std::list<Player*> myList;
                            const Map::PlayerList &pl = me->GetMap()->GetPlayers();
                            for (Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr)
                                if (Player* p = itr->GetSource())
                                    if (p->IsAlive() && p != me->GetVictim() && !p->IsGameMaster() && !p->HasAura(SPELL_UNCONTROLLABLE_FRENZY))
                                        myList.push_back(p);
                            if (!myList.empty())
                            {
                                myList.sort(acore::ObjectDistanceOrderPred(me->GetVictim()));
                                Player* target = myList.front();
                                if (me->GetVictim()->GetGUID() != _tankGUID || target->GetGUID() != _offtankGUID)
                                {
                                    // remove manually from previous, single target flag has nothing to do with this shit as caster is in every case different... tc retards
                                    if (_tankGUID)
                                        if (Player* prevTank = ObjectAccessor::GetPlayer(*me, _tankGUID))
                                        {
                                            prevTank->RemoveAurasDueToSpell(SPELL_BLOOD_MIRROR_DAMAGE);
                                            prevTank->RemoveAurasDueToSpell(SPELL_BLOOD_MIRROR_VISUAL);
                                        }
                                    if (_offtankGUID)
                                        if (Player* prevOfftank = ObjectAccessor::GetPlayer(*me, _offtankGUID))
                                            prevOfftank->RemoveAurasDueToSpell(SPELL_BLOOD_MIRROR_DUMMY);

                                    if (target->GetDistance(me->GetVictim()) > 39.0f || me->GetDistance(me->GetVictim()) > 39.0f)
                                    {
                                        _tankGUID = 0;
                                        _offtankGUID = 0;
                                        events.ScheduleEvent(EVENT_BLOOD_MIRROR, 2500);
                                        break;
                                    }

                                    _tankGUID = me->GetVictim()->GetGUID();
                                    _offtankGUID = target->GetGUID();
                                    target->CastSpell(me->GetVictim(), SPELL_BLOOD_MIRROR_DAMAGE, true);
                                    me->GetVictim()->CastSpell(target, SPELL_BLOOD_MIRROR_DUMMY, true);
                                    me->CastSpell(me->GetVictim(), SPELL_BLOOD_MIRROR_VISUAL, false);

                                    if (Is25ManRaid() && target->GetQuestStatus(QUEST_BLOOD_INFUSION) == QUEST_STATUS_INCOMPLETE &&
                                        target->HasAura(SPELL_UNSATED_CRAVING) && !target->HasAura(SPELL_THIRST_QUENCHED) && !target->HasAura(SPELL_GUSHING_WOUND))
                                        target->CastSpell(target, SPELL_GUSHING_WOUND, TRIGGERED_FULL_MASK);
                                }
                            }
                        }
                        events.ScheduleEvent(EVENT_BLOOD_MIRROR, 2500);
                        break;
                    case EVENT_DELIRIOUS_SLASH:
                        if (!me->HasReactState(REACT_PASSIVE))
                        {
                            Unit* target = NULL;
                            if (_offtankGUID)
                                if (Unit* t = ObjectAccessor::GetUnit(*me, _offtankGUID))
                                    if (t->IsAlive() && t->GetDistance(me) < 10.0f)
                                        target = t;
                            if (!target)
                                if (me->GetVictim() && me->GetVictim()->GetDistance(me) < 10.0f)
                                    target = me->GetVictim();
                            if (!target)
                            {
                                events.ScheduleEvent(EVENT_DELIRIOUS_SLASH, 5000);
                                break;
                            }
                            me->CastSpell(target, SPELL_DELIRIOUS_SLASH, false);
                            events.ScheduleEvent(EVENT_DELIRIOUS_SLASH, urand(20000, 24000));
                            break;
                        }
                        events.ScheduleEvent(EVENT_DELIRIOUS_SLASH, 5000);
                        break;
                    case EVENT_PACT_OF_THE_DARKFALLEN:
                        if (!me->HasReactState(REACT_PASSIVE))
                        {
                            std::list<Player*> myList;
                            const Map::PlayerList &pl = me->GetMap()->GetPlayers();
                            for (Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr)
                                if (Player* p = itr->GetSource())
                                    if (p->IsAlive() && p != me->GetVictim() && p->GetGUID() != _offtankGUID && !p->IsGameMaster() && p->GetDistance(me) < 100.0f && !p->HasAura(SPELL_UNCONTROLLABLE_FRENZY))
                                        myList.push_back(p);
                            acore::Containers::RandomResizeList(myList, Is25ManRaid() ? 3 : 2);
                            if (myList.size() > 1)
                            {
                                Talk(SAY_PACT_OF_THE_DARKFALLEN);
                                for (std::list<Player*>::iterator itr = myList.begin(); itr != myList.end(); ++itr)
                                    me->CastSpell(*itr, SPELL_PACT_OF_THE_DARKFALLEN, false);
                                events.ScheduleEvent(EVENT_PACT_OF_THE_DARKFALLEN, 30000);
                            }
                            else
                                events.ScheduleEvent(EVENT_PACT_OF_THE_DARKFALLEN, 5000);
                            break;
                        }
                        events.ScheduleEvent(EVENT_PACT_OF_THE_DARKFALLEN, 5000);
                        break;
                    case EVENT_SWARMING_SHADOWS:
                        if (!me->HasReactState(REACT_PASSIVE))
                        {
                            std::list<Player*> myList;
                            const Map::PlayerList &pl = me->GetMap()->GetPlayers();
                            for (Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr)
                                if (Player* p = itr->GetSource())
                                    if (p->IsAlive() && p != me->GetVictim() && p->GetGUID() != _offtankGUID && !p->IsGameMaster() && !p->HasAura(SPELL_PACT_OF_THE_DARKFALLEN) && !p->HasAura(SPELL_UNCONTROLLABLE_FRENZY))
                                        myList.push_back(p);

                            if (!myList.empty())
                            {
                                acore::Containers::RandomResizeList(myList, 1);
                                Player* target = myList.front();
                                Talk(EMOTE_SWARMING_SHADOWS, target);
                                Talk(SAY_SWARMING_SHADOWS);
                                me->CastSpell(target, SPELL_SWARMING_SHADOWS, false);
                            }

                            events.ScheduleEvent(EVENT_SWARMING_SHADOWS, 30000);
                            break;
                        }
                        events.ScheduleEvent(EVENT_SWARMING_SHADOWS, 5000);
                        break;
                    case EVENT_TWILIGHT_BLOODBOLT:
                        if (!me->HasReactState(REACT_PASSIVE))
                        {
                            std::list<Player*> myList;
                            const Map::PlayerList &pl = me->GetMap()->GetPlayers();
                            for (Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr)
                                if (Player* p = itr->GetSource())
                                    if (p->IsAlive() && p != me->GetVictim() && p->GetGUID() != _offtankGUID && !p->IsGameMaster() && !p->HasAura(SPELL_PACT_OF_THE_DARKFALLEN) && !p->HasAura(SPELL_UNCONTROLLABLE_FRENZY))
                                        myList.push_back(p);

                            acore::Containers::RandomResizeList<Player*>(myList, uint32(Is25ManRaid() ? 4 : 2));
                            for (std::list<Player*>::iterator itr = myList.begin(); itr != myList.end(); ++itr)
                                me->CastSpell(*itr, SPELL_TWILIGHT_BLOODBOLT, false);
                            me->CastSpell(me, SPELL_TWILIGHT_BLOODBOLT_TARGET, false);
                            events.ScheduleEvent(EVENT_TWILIGHT_BLOODBOLT, urand(10000, 15000));
                            break;
                        }
                        events.ScheduleEvent(EVENT_TWILIGHT_BLOODBOLT, 5000);
                        break;
                    case EVENT_AIR_PHASE:
                        me->AttackStop();
                        me->SetReactState(REACT_PASSIVE);
                        me->GetMotionMaster()->MovePoint(POINT_CENTER, centerPos);
                        break;
                    case EVENT_AIR_START_FLYING:
                        me->SendMeleeAttackStop(me->GetVictim());
                        me->GetMotionMaster()->MoveIdle();
                        me->DisableSpline();
                        me->SetCanFly(true);
                        me->SetDisableGravity(true);
                        me->SetHover(true);
                        me->SendMovementFlagUpdate();
                        me->GetMotionMaster()->MoveTakeoff(POINT_AIR, airPos, 0.642857f * 7.0f);
                        break;
                    case EVENT_AIR_FLY_DOWN:
                        me->GetMotionMaster()->MoveLand(POINT_GROUND, centerPos, 0.642857f * 7.0f);
                        break;
                }

                DoMeleeAttackIfReady();
            }

            void CleanAuras()
            {
                instance->DoRemoveAurasDueToSpellOnPlayers(ESSENCE_OF_BLOOD_QUEEN);
                instance->DoRemoveAurasDueToSpellOnPlayers(ESSENCE_OF_BLOOD_QUEEN_PLR);
                instance->DoRemoveAurasDueToSpellOnPlayers(FRENZIED_BLOODTHIRST);
                instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_FRENZIED_BLOODTHIRST_VISUAL);
                instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_UNCONTROLLABLE_FRENZY);
                instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_BLOOD_MIRROR_DAMAGE);
                instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_BLOOD_MIRROR_VISUAL);
                instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_BLOOD_MIRROR_DUMMY);
                instance->DoRemoveAurasDueToSpellOnPlayers(DELIRIOUS_SLASH);
                instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_PACT_OF_THE_DARKFALLEN);
                instance->DoRemoveAurasDueToSpellOnPlayers(PRESENCE_OF_THE_DARKFALLEN);
            }

            bool WasVampire(uint64 guid)
            {
                return _vampires.count(guid) != 0;
            }

            bool WasBloodbolted(uint64 guid)
            {
                return _bloodboltedPlayers.count(guid) != 0;
            }

            void SetGUID(uint64 guid, int32 type = 0)
            {
                switch (type)
                {
                    case GUID_BLOODBOLT:
                        _bloodboltedPlayers.insert(guid);
                        break;
                    case GUID_VAMPIRE:
                        _vampires.insert(guid);
                        break;
                    default:
                        break;
                }
            }

            void EnterEvadeMode()
            {
                const Map::PlayerList &pl = me->GetMap()->GetPlayers();
                for (Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr)
                    if (Player* p = itr->GetSource())
                        if (p->IsAlive() && p->HasAura(SPELL_UNCONTROLLABLE_FRENZY))
                            Unit::Kill(me, p);
                
                if (_killMinchar)
                {
                    if (!me->IsAlive())
                        return;
                    _EnterEvadeMode();
                    Reset();
                    GoToMinchar();
                    return;
                }

                BossAI::EnterEvadeMode();
            }

            bool CanAIAttack(const Unit*  /*target*/) const
            {
                return me->IsVisible();
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetIcecrownCitadelAI<boss_blood_queen_lana_thelAI>(creature);
        }
};

// shortened version for clear code
typedef boss_blood_queen_lana_thel::boss_blood_queen_lana_thelAI LanaThelAI;

class spell_blood_queen_pact_of_the_darkfallen_dmg : public SpellScriptLoader
{
    public:
        spell_blood_queen_pact_of_the_darkfallen_dmg() : SpellScriptLoader("spell_blood_queen_pact_of_the_darkfallen_dmg") { }

        class spell_blood_queen_pact_of_the_darkfallen_dmg_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_blood_queen_pact_of_the_darkfallen_dmg_AuraScript);

            bool Validate(SpellInfo const* /*spell*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_PACT_OF_THE_DARKFALLEN_DAMAGE))
                    return false;
                return true;
            }

            // this is an additional effect to be executed
            void PeriodicTick(AuraEffect const* aurEff)
            {
                if ((aurEff->GetTickNumber()%2) == 0)
                    return;
                SpellInfo const* damageSpell = sSpellMgr->GetSpellInfo(SPELL_PACT_OF_THE_DARKFALLEN_DAMAGE);
                int32 damage = damageSpell->Effects[EFFECT_0].CalcValue();
                float herobonus = ((GetTarget()->FindMap() && GetTarget()->FindMap()->IsHeroic()) ? 0.2f : 0.0f);
                float multiplier = 0.5f + herobonus + 0.1f * uint32(aurEff->GetTickNumber()/10); // do not convert to 0.01f - we need tick number/10 as INT (damage increases every 10 ticks)
                damage = int32(damage * multiplier);
                GetTarget()->CastCustomSpell(SPELL_PACT_OF_THE_DARKFALLEN_DAMAGE, SPELLVALUE_BASE_POINT0, damage, GetTarget(), true);
            }

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_blood_queen_pact_of_the_darkfallen_dmg_AuraScript::PeriodicTick, EFFECT_1, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_blood_queen_pact_of_the_darkfallen_dmg_AuraScript();
        }
};

class spell_blood_queen_pact_of_the_darkfallen : public SpellScriptLoader
{
    public:
        spell_blood_queen_pact_of_the_darkfallen() : SpellScriptLoader("spell_blood_queen_pact_of_the_darkfallen") { }

        class spell_blood_queen_pact_of_the_darkfallen_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_blood_queen_pact_of_the_darkfallen_SpellScript);

            void FilterTargets(std::list<WorldObject*>& targets)
            {
                targets.remove_if(acore::UnitAuraCheck(false, SPELL_PACT_OF_THE_DARKFALLEN));

                bool remove = true;
                std::list<WorldObject*>::const_iterator itr, itr2, itrEnd = targets.end();
                for (itr = targets.begin(); itr != itrEnd && remove; ++itr)
                {
                    if (GetCaster()->GetExactDist2d(*itr) > 5.0f)
                        remove = false;

                    for (itr2 = targets.begin(); itr2 != itrEnd && remove; ++itr2)
                        if (itr != itr2 && (*itr2)->GetExactDist2d(*itr) > 5.0f)
                            remove = false;
                }

                if (remove)
                    if (InstanceScript* instance = GetCaster()->GetInstanceScript())
                    {
                        targets.clear();
                        instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_PACT_OF_THE_DARKFALLEN);
                    }
            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_blood_queen_pact_of_the_darkfallen_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ALLY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_blood_queen_pact_of_the_darkfallen_SpellScript();
        }
};

class spell_blood_queen_pact_of_the_darkfallen_dmg_target : public SpellScriptLoader
{
    public:
        spell_blood_queen_pact_of_the_darkfallen_dmg_target() : SpellScriptLoader("spell_blood_queen_pact_of_the_darkfallen_dmg_target") { }

        class spell_blood_queen_pact_of_the_darkfallen_dmg_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_blood_queen_pact_of_the_darkfallen_dmg_SpellScript);

            void FilterTargets(std::list<WorldObject*>& unitList)
            {
                unitList.remove_if(acore::UnitAuraCheck(true, SPELL_PACT_OF_THE_DARKFALLEN));
                unitList.push_back(GetCaster());
            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_blood_queen_pact_of_the_darkfallen_dmg_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ALLY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_blood_queen_pact_of_the_darkfallen_dmg_SpellScript();
        }
};

class BloodboltHitCheck
{
    public:
        explicit BloodboltHitCheck(LanaThelAI* ai) : _ai(ai) {}

        bool operator()(WorldObject* object) const
        {
            return _ai->WasBloodbolted(object->GetGUID());
        }

    private:
        LanaThelAI* _ai;
};

class spell_blood_queen_bloodbolt : public SpellScriptLoader
{
    public:
        spell_blood_queen_bloodbolt() : SpellScriptLoader("spell_blood_queen_bloodbolt") { }

        class spell_blood_queen_bloodbolt_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_blood_queen_bloodbolt_SpellScript);

            bool Validate(SpellInfo const* /*spell*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_TWILIGHT_BLOODBOLT_FROM_WHIRL))
                    return false;
                return true;
            }

            bool Load()
            {
                return GetCaster()->GetEntry() == NPC_BLOOD_QUEEN_LANA_THEL;
            }

            void FilterTargets(std::list<WorldObject*>& targets)
            {
                uint32 targetCount = (targets.size() + 2) / 3;
                targets.remove_if(BloodboltHitCheck(static_cast<LanaThelAI*>(GetCaster()->GetAI())));
                acore::Containers::RandomResizeList(targets, targetCount);
                // mark targets now, effect hook has missile travel time delay (might cast next in that time)
                for (std::list<WorldObject*>::const_iterator itr = targets.begin(); itr != targets.end(); ++itr)
                    GetCaster()->GetAI()->SetGUID((*itr)->GetGUID(), GUID_BLOODBOLT);
            }

            void HandleScript(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                GetCaster()->CastSpell(GetHitUnit(), SPELL_TWILIGHT_BLOODBOLT_FROM_WHIRL, true);
            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_blood_queen_bloodbolt_SpellScript::FilterTargets, EFFECT_1, TARGET_UNIT_SRC_AREA_ENEMY);
                OnEffectHitTarget += SpellEffectFn(spell_blood_queen_bloodbolt_SpellScript::HandleScript, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_blood_queen_bloodbolt_SpellScript();
        }
};

class spell_blood_queen_frenzied_bloodthirst : public SpellScriptLoader
{
    public:
        spell_blood_queen_frenzied_bloodthirst() : SpellScriptLoader("spell_blood_queen_frenzied_bloodthirst") { }

        class spell_blood_queen_frenzied_bloodthirst_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_blood_queen_frenzied_bloodthirst_AuraScript);

            void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (InstanceScript* instance = GetTarget()->GetInstanceScript())
                    if (Creature* bloodQueen = ObjectAccessor::GetCreature(*GetTarget(), instance->GetData64(DATA_BLOOD_QUEEN_LANA_THEL)))
                        bloodQueen->AI()->Talk(EMOTE_BLOODTHIRST, GetTarget());
            }

            void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                Unit* target = GetTarget();
                if (GetTargetApplication()->GetRemoveMode() == AURA_REMOVE_BY_EXPIRE)
                    if (InstanceScript* instance = target->GetInstanceScript())
                        if (Creature* bloodQueen = ObjectAccessor::GetCreature(*target, instance->GetData64(DATA_BLOOD_QUEEN_LANA_THEL)))
                            if (bloodQueen->IsAlive() && bloodQueen->IsInCombat())
                            {
                                // this needs to be done BEFORE charm aura or we hit an assert in Unit::SetCharmedBy
                                if (target->GetVehicleKit())
                                    target->RemoveVehicleKit();

                                bloodQueen->AI()->Talk(SAY_MIND_CONTROL);
                                bloodQueen->CastSpell(target, SPELL_UNCONTROLLABLE_FRENZY, true);
                            }
            }

            void Register()
            {
                OnEffectApply += AuraEffectApplyFn(spell_blood_queen_frenzied_bloodthirst_AuraScript::OnApply, EFFECT_0, SPELL_AURA_OVERRIDE_SPELLS, AURA_EFFECT_HANDLE_REAL);
                AfterEffectRemove += AuraEffectRemoveFn(spell_blood_queen_frenzied_bloodthirst_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_OVERRIDE_SPELLS, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_blood_queen_frenzied_bloodthirst_AuraScript();
        }
};

class spell_blood_queen_essence_of_the_blood_queen : public SpellScriptLoader
{
    public:
        spell_blood_queen_essence_of_the_blood_queen() : SpellScriptLoader("spell_blood_queen_essence_of_the_blood_queen") { }

        class spell_blood_queen_essence_of_the_blood_queen_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_blood_queen_essence_of_the_blood_queen_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_ESSENCE_OF_THE_BLOOD_QUEEN_HEAL))
                    return false;
                return true;
            }

            void OnProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
            {
                PreventDefaultAction();
                int32 heal = CalculatePct(int32(eventInfo.GetDamageInfo()->GetDamage()), aurEff->GetAmount());
                GetTarget()->CastCustomSpell(SPELL_ESSENCE_OF_THE_BLOOD_QUEEN_HEAL, SPELLVALUE_BASE_POINT0, heal, GetTarget(), TRIGGERED_FULL_MASK, NULL, aurEff);
            }

            void Register()
            {
                OnEffectProc += AuraEffectProcFn(spell_blood_queen_essence_of_the_blood_queen_AuraScript::OnProc, EFFECT_1, SPELL_AURA_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_blood_queen_essence_of_the_blood_queen_AuraScript();
        }
};

class spell_blood_queen_vampiric_bite : public SpellScriptLoader
{
    public:
        spell_blood_queen_vampiric_bite() : SpellScriptLoader("spell_blood_queen_vampiric_bite") { }

        class spell_blood_queen_vampiric_bite_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_blood_queen_vampiric_bite_SpellScript);

            bool Validate(SpellInfo const* /*spell*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_ESSENCE_OF_THE_BLOOD_QUEEN_PLR))
                    return false;
                if (!sSpellMgr->GetSpellInfo(SPELL_FRENZIED_BLOODTHIRST))
                    return false;
                if (!sSpellMgr->GetSpellInfo(SPELL_PRESENCE_OF_THE_DARKFALLEN_DUMMY))
                    return false;
                return true;
            }

            SpellCastResult CheckTarget()
            {
                if (GetExplTargetUnit()->GetMapId() != 631)
                    return SPELL_FAILED_CANT_DO_THAT_RIGHT_NOW;
                if (IsVampire(GetExplTargetUnit()))
                {
                    SetCustomCastResultMessage(SPELL_CUSTOM_ERROR_CANT_TARGET_VAMPIRES);
                    return SPELL_FAILED_CUSTOM_ERROR;
                }
                if (InstanceScript* instance = GetExplTargetUnit()->GetInstanceScript())
                    if (instance->GetBossState(DATA_BLOOD_QUEEN_LANA_THEL) == IN_PROGRESS)
                        return SPELL_CAST_OK;

                return SPELL_FAILED_CANT_DO_THAT_RIGHT_NOW;
            }

            void OnCast()
            {
                if (GetCaster()->GetTypeId() != TYPEID_PLAYER || GetCaster()->GetMapId() != 631)
                    return;
                InstanceScript* instance = GetCaster()->GetInstanceScript();
                if (!instance || instance->GetBossState(DATA_BLOOD_QUEEN_LANA_THEL) != IN_PROGRESS)
                    return;

                uint32 spellId = sSpellMgr->GetSpellIdForDifficulty(SPELL_FRENZIED_BLOODTHIRST, GetCaster());
                GetCaster()->RemoveAura(spellId, 0, 0, AURA_REMOVE_BY_ENEMY_SPELL);
                GetCaster()->CastSpell(GetCaster(), SPELL_ESSENCE_OF_THE_BLOOD_QUEEN_PLR, TRIGGERED_FULL_MASK);

                if (Aura* aura = GetCaster()->GetAura(SPELL_GUSHING_WOUND))
                {
                    if (aura->GetStackAmount() == 3)
                    {
                        GetCaster()->CastSpell(GetCaster(), SPELL_THIRST_QUENCHED, TRIGGERED_FULL_MASK);
                        GetCaster()->RemoveAura(aura);
                    }
                    else
                        GetCaster()->CastSpell(GetCaster(), SPELL_GUSHING_WOUND, TRIGGERED_FULL_MASK);
                }

                if (InstanceScript* instance = GetCaster()->GetInstanceScript())
                    if (Creature* bloodQueen = ObjectAccessor::GetCreature(*GetCaster(), instance->GetData64(DATA_BLOOD_QUEEN_LANA_THEL)))
                        bloodQueen->AI()->SetGUID(GetHitUnit()->GetGUID(), GUID_VAMPIRE);
            }

            void HandlePresence(SpellEffIndex /*effIndex*/)
            {
                GetHitUnit()->CastSpell(GetHitUnit(), SPELL_PRESENCE_OF_THE_DARKFALLEN_DUMMY, TRIGGERED_FULL_MASK);
                GetHitUnit()->CastSpell(GetHitUnit(), SPELL_PRESENCE_OF_THE_DARKFALLEN_SE, TRIGGERED_FULL_MASK);
            }

            void Register()
            {
                OnCheckCast += SpellCheckCastFn(spell_blood_queen_vampiric_bite_SpellScript::CheckTarget);
                BeforeHit += SpellHitFn(spell_blood_queen_vampiric_bite_SpellScript::OnCast);
                OnEffectHitTarget += SpellEffectFn(spell_blood_queen_vampiric_bite_SpellScript::HandlePresence, EFFECT_1, SPELL_EFFECT_TRIGGER_SPELL);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_blood_queen_vampiric_bite_SpellScript();
        }
};

class spell_blood_queen_swarming_shadows_floor_dmg : public SpellScriptLoader
{
    public:
        spell_blood_queen_swarming_shadows_floor_dmg() : SpellScriptLoader("spell_blood_queen_swarming_shadows_floor_dmg") { }

        class spell_blood_queen_swarming_shadows_floor_dmg_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_blood_queen_swarming_shadows_floor_dmg_SpellScript);

            void FilterTargets(std::list<WorldObject*>& targets)
            {
                targets.remove_if(acore::AllWorldObjectsInExactRange(GetCaster(), GetSpellInfo()->Effects[0].CalcRadius(), true));
            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_blood_queen_swarming_shadows_floor_dmg_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_blood_queen_swarming_shadows_floor_dmg_SpellScript();
        }
};

class spell_blood_queen_presence_of_the_darkfallen : public SpellScriptLoader
{
    public:
        spell_blood_queen_presence_of_the_darkfallen() : SpellScriptLoader("spell_blood_queen_presence_of_the_darkfallen") { }

        class spell_blood_queen_presence_of_the_darkfallen_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_blood_queen_presence_of_the_darkfallen_SpellScript);

            void HandleScript(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                if (!GetHitUnit())
                    return;

                if (InstanceScript* instance = GetHitUnit()->GetInstanceScript())
                    GetHitUnit()->CastSpell((Unit*)NULL, GetSpellInfo()->Effects[effIndex].TriggerSpell, true, NULL, NULL, instance->GetData64(DATA_BLOOD_QUEEN_LANA_THEL));
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_blood_queen_presence_of_the_darkfallen_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_FORCE_CAST);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_blood_queen_presence_of_the_darkfallen_SpellScript();
        }
};

class achievement_once_bitten_twice_shy : public AchievementCriteriaScript
{
public:
    achievement_once_bitten_twice_shy(const char* name, uint8 spawnMode, bool wasVampire) : AchievementCriteriaScript(name), _spawnMode(spawnMode), _wasVampire(wasVampire) { }

    bool OnCheck(Player* source, Unit* target)
    {
        if (!target || !target->FindMap())
            return false;

        if (LanaThelAI* lanaThelAI = CAST_AI(LanaThelAI, target->GetAI()))
            return (target->GetMap()->GetSpawnMode()%2) == _spawnMode && lanaThelAI->WasVampire(source->GetGUID()) == _wasVampire;
        return false;
    }

    uint8 _spawnMode;
    bool _wasVampire;
};

void AddSC_boss_blood_queen_lana_thel()
{
    new boss_blood_queen_lana_thel();
    new spell_blood_queen_pact_of_the_darkfallen_dmg();
    new spell_blood_queen_pact_of_the_darkfallen();
    new spell_blood_queen_pact_of_the_darkfallen_dmg_target();
    new spell_blood_queen_bloodbolt();
    new spell_blood_queen_frenzied_bloodthirst();
    new spell_blood_queen_essence_of_the_blood_queen();
    new spell_blood_queen_vampiric_bite();
    new spell_blood_queen_swarming_shadows_floor_dmg();
    new spell_blood_queen_presence_of_the_darkfallen();
    new achievement_once_bitten_twice_shy("achievement_once_bitten_twice_shy_n_10", 0, false);
    new achievement_once_bitten_twice_shy("achievement_once_bitten_twice_shy_v_10", 0, true);
    new achievement_once_bitten_twice_shy("achievement_once_bitten_twice_shy_n_25", 1, false);
    new achievement_once_bitten_twice_shy("achievement_once_bitten_twice_shy_v_25", 1, true);
}