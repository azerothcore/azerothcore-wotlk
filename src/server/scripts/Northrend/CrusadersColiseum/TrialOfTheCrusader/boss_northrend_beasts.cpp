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
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "Vehicle.h"
#include "trial_of_the_crusader.h"

/***********
** GORMOK
***********/

enum GormokSpells
{
    SPELL_IMPALE                        = 66331,
    SPELL_STAGGERING_STOMP              = 67648,
    SPELL_RISING_ANGER                  = 66636,
    SPELL_JUMP_TO_HAND                  = 66342,
    //Snobold
    SPELL_SNOBOLLED                     = 66406,
    SPELL_BATTER                        = 66408,
    SPELL_FIRE_BOMB                     = 66313,
    SPELL_HEAD_CRACK                    = 66407,
    SPELL_FULL_HEAL                     = 17683,
};

enum GormokEvents
{
    EVENT_SPELL_IMPALE = 1,
    EVENT_SPELL_STAGGERING_STOMP,
    EVENT_PICK_SNOBOLD_TARGET,

    EVENT_SPELL_SNOBOLLED,
    EVENT_SPELL_BATTER,
    EVENT_SPELL_FIRE_BOMB,
    EVENT_SPELL_HEAD_CRACK,
    EVENT_DISMOUNTED_ATTACK,
};

enum GormokActions
{
    ACTION_GORMOK_DIED = 1,
    ACTION_SNOBOLD_MISSED,
};

enum GormokData
{
    DATA_RELEASED_SNOBOLD = 1,
    DATA_SNOBOLD_CARRIER,
};

enum GormokNPCs
{
    NPC_SNOBOLD_VASSAL                  = 34800,
};

enum Yells
{
    // Gormok
    EMOTE_SNOBOLLED         = 0,

    // Acidmaw & Dreadscale
    EMOTE_ENRAGE            = 0,
    WHISPER_PARALYTIC_TOXIN = 1, // Acidmaw only

    // Icehowl
    EMOTE_TRAMPLE_STARE     = 0,
    EMOTE_TRAMPLE_CRASH     = 1,
    EMOTE_TRAMPLE_FAIL      = 2,
};

class npc_snobold_vassal : public CreatureScript
{
public:
    npc_snobold_vassal() : CreatureScript("npc_snobold_vassal") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetTrialOfTheCrusaderAI<npc_snobold_vassalAI>(pCreature);
    }

    struct npc_snobold_vassalAI : public ScriptedAI
    {
        npc_snobold_vassalAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            pInstance = pCreature->GetInstanceScript();
            TargetGUID.Clear();
            me->SetReactState(REACT_PASSIVE);
        }

        InstanceScript* pInstance;
        EventMap events;
        ObjectGuid TargetGUID;
        bool Dismounted = false;

        void Reset() override
        {
            events.Reset();
            events.ScheduleEvent(EVENT_SPELL_FIRE_BOMB, 10s, 30s);
        }

        void JustEngagedWith(Unit*  /*who*/) override
        {
            if (Dismounted)
                return;

            events.Reset();
            events.ScheduleEvent(EVENT_SPELL_SNOBOLLED, 1500ms);
            events.ScheduleEvent(EVENT_SPELL_BATTER, 5s);
            events.ScheduleEvent(EVENT_SPELL_HEAD_CRACK, 25s);
        }

        void AttackStart(Unit* who) override
        {
            if (!Dismounted && who->GetGUID() != TargetGUID)
                return;
            ScriptedAI::AttackStart(who);
        }

        void MoveInLineOfSight(Unit* /*who*/) override {}

        void SetGUID(ObjectGuid const& guid, int32 id) override
        {
            if (id != DATA_SNOBOLD_CARRIER)
                return;

            TargetGUID = guid;
            if (Player* carrier = ObjectAccessor::GetPlayer(*me, guid))
                AttackStart(carrier);
        }

        void EnterEvadeMode(EvadeReason why) override
        {
            // Nothing cleans up a dismounted snobold once Gormok's corpse is gone
            if (Dismounted)
            {
                me->DespawnOrUnsummon();
                return;
            }

            ScriptedAI::EnterEvadeMode(why);
        }

        void LoseCarrier()
        {
            me->RemoveAllAuras();
            me->GetThreatMgr().ClearAllThreat();
            me->CombatStop(true);
            me->SetHealth(me->GetMaxHealth());
            TargetGUID.Clear();
            Creature* gormok = GetGormok();
            if (gormok && gormok->IsAlive())
                BoardGormok(gormok);
            else // Gormok is dead or gone, so fight on like the Snobolds ejected from him
                DoAction(ACTION_GORMOK_DIED);
        }

        Creature* GetGormok() const
        {
            return pInstance ? ObjectAccessor::GetCreature(*me, pInstance->GetGuidData(TYPE_GORMOK)) : nullptr;
        }

        // Prefers players away from Gormok's melee, falling back to anyone when they are all on him
        Player* SelectFireBombTarget() const
        {
            Creature* gormok = GetGormok();
            std::vector<Player*> everyone;
            std::vector<Player*> awayFromGormok;
            for (auto const& itr : me->GetMap()->GetPlayers())
            {
                Player* player = itr.GetSource();
                if (!player || !player->IsAlive() || player->IsGameMaster())
                    continue;

                everyone.push_back(player);
                if (!gormok || !gormok->IsAlive() || !player->IsWithinMeleeRange(gormok))
                    awayFromGormok.push_back(player);
            }

            std::vector<Player*> const& candidates = awayFromGormok.empty() ? everyone : awayFromGormok;
            return candidates.empty() ? nullptr : Acore::Containers::SelectRandomContainerElement(candidates);
        }

        bool BoardGormok(Creature* gormok)
        {
            if (Vehicle* vk = gormok->GetVehicleKit())
                for (uint8 i = 0; i < 4; ++i)
                    if (!vk->GetPassenger(i))
                    {
                        me->EnterVehicleUnattackable(gormok, i);
                        Reset();
                        return true;
                    }

            return false;
        }

        // Thrown at someone who can't carry it, the Snobold lands, walks back and climbs onto a free seat
        void ReturnToGormok()
        {
            scheduler.Schedule(1100ms, [this](TaskContext context)
            {
                Creature* gormok = GetGormok();
                if (!gormok || !gormok->IsAlive())
                    return;

                if (context.GetRepeatCounter() == 0)
                    me->GetMotionMaster()->MoveFollow(gormok, 0.0f, 0.0f, MOTION_SLOT_ACTIVE, false);

                if (!me->IsWithinMeleeRange(gormok))
                {
                    context.Repeat(250ms);
                    return;
                }

                me->GetMotionMaster()->Clear();
                if (BoardGormok(gormok))
                    scheduler.Schedule(1200ms, [this](TaskContext /*context*/)
                    {
                        DoCastSelf(SPELL_FULL_HEAL);
                    });
                else
                    me->DespawnOrUnsummon();
            });
        }

        void UpdateAI(uint32 diff) override
        {
            scheduler.Update(diff);

            Unit* t = nullptr;
            if (Dismounted)
            {
                if (me->GetReactState() != REACT_PASSIVE && !UpdateVictim())
                    return;

                t = me->GetVictim();
            }
            else
            {
                if (!me->GetVehicle())
                {
                    // Ejected because the carrier left the map or stopped being a vehicle when Northrend Beasts ended
                    if (TargetGUID)
                        LoseCarrier();
                    return;
                }

                t = ObjectAccessor::GetUnit(*me, TargetGUID);
                if (!t)
                    t = me->GetVehicleBase();
            }

            if (!Dismounted && t->isDead())
            {
                LoseCarrier();
                return;
            }

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case 0:
                    break;
                case EVENT_DISMOUNTED_ATTACK:
                    me->SetReactState(REACT_AGGRESSIVE);
                    DoZoneInCombat();
                    // An unengaged creature never evades, so a Snobold with nobody left to fight would idle forever
                    if (!me->IsEngaged())
                    {
                        me->DespawnOrUnsummon();
                        return;
                    }
                    events.ScheduleEvent(EVENT_SPELL_HEAD_CRACK, 1s, 5s);
                    break;
                case EVENT_SPELL_SNOBOLLED:
                    if (t->IsPlayer())
                        me->CastSpell((Unit*)nullptr, SPELL_SNOBOLLED, true);

                    break;
                case EVENT_SPELL_BATTER:
                    if (t->IsPlayer())
                        me->CastSpell(t, SPELL_BATTER);
                    events.Repeat(6s, 8s);
                    break;
                case EVENT_SPELL_FIRE_BOMB:
                    if (Dismounted || !t->IsPlayer())
                        if (Player* target = SelectFireBombTarget())
                            DoCast(target, SPELL_FIRE_BOMB);
                    events.Repeat(20s, 30s);
                    break;
                case EVENT_SPELL_HEAD_CRACK:
                    if (t->IsPlayer())
                        me->CastSpell(t, SPELL_HEAD_CRACK);
                    events.Repeat(30s, 35s);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*pKiller*/) override
        {
            if (Unit* t = ObjectAccessor::GetUnit(*me, TargetGUID))
                if (t->IsAlive())
                    t->RemoveAurasDueToSpell(SPELL_SNOBOLLED);
        }

        void DoAction(int32 param) override
        {
            switch (param)
            {
                case ACTION_SNOBOLD_MISSED:
                    ReturnToGormok();
                    break;
                case ACTION_GORMOK_DIED:
                    // Gormok's death ejects his passengers; they keep bombing and join the fight shortly after landing
                    if (TargetGUID)
                        return;

                    Dismounted = true;
                    scheduler.CancelAll();
                    events.Reset();
                    events.ScheduleEvent(EVENT_SPELL_FIRE_BOMB, 1s, 12s);
                    events.ScheduleEvent(EVENT_DISMOUNTED_ATTACK, 5s);
                    break;
            }
        }
    };
};

class boss_gormok : public CreatureScript
{
public:
    boss_gormok() : CreatureScript("boss_gormok") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetTrialOfTheCrusaderAI<boss_gormokAI>(pCreature);
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
        ObjectGuid PlayerGUID;

        void Reset() override
        {
            events.Reset();
            summons.DespawnAll();
            PlayerGUID.Clear();
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            me->setActive(true);
            events.Reset();
            events.RescheduleEvent(EVENT_SPELL_IMPALE, 9s, 10s);
            events.RescheduleEvent(EVENT_SPELL_STAGGERING_STOMP, 15s);
            events.RescheduleEvent(EVENT_PICK_SNOBOLD_TARGET, 16s, 24s);

            // refresh snobold position
            if (Vehicle* vk = me->GetVehicleKit())
                for( uint8 i = 0; i < 4; ++i )
                    if (Unit* snobold = vk->GetPassenger(i))
                        snobold->SendMovementFlagUpdate();
        }

        void JustReachedHome() override
        {
            me->setActive(false);
        }

        void MoveInLineOfSight(Unit* /*who*/) override {}

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case 0:
                    break;
                case EVENT_SPELL_IMPALE:
                    if (!me->HasUnitFlag(UNIT_FLAG_DISARMED))
                    {
                        if (Unit* victim = me->GetVictim())
                            me->CastSpell(victim, SPELL_IMPALE, false);
                        events.Repeat(9s, 10s);
                    }
                    else
                        events.Repeat(2500ms);
                    break;
                case EVENT_SPELL_STAGGERING_STOMP:
                    me->CastSpell((Unit*)nullptr, SPELL_STAGGERING_STOMP, false);
                    events.Repeat(20s, 25s);
                    break;
                case EVENT_PICK_SNOBOLD_TARGET:
                    if (Vehicle* vk = me->GetVehicleKit())
                        for( uint8 i = 0; i < 4; ++i )
                            if (Unit* snobold = vk->GetPassenger(i); snobold && !snobold->HasUnitState(UNIT_STATE_CASTING))
                            {
                                GuidVector validPlayers;
                                Map::PlayerList const& pl = me->GetMap()->GetPlayers();
                                for( Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr )
                                {
                                    // Players who can't carry a Snobold are still picked; the throw then falls short
                                    if (Player* p = itr->GetSource())
                                        if (p->IsAlive() && !p->IsGameMaster())
                                            validPlayers.push_back(p->GetGUID());
                                }

                                if (!validPlayers.empty())
                                    if (Player* p = ObjectAccessor::GetPlayer(*me, validPlayers.at(urand(0, validPlayers.size() - 1))))
                                    {
                                        // Untriggered so clients see the cast, as on retail. Its aura holds the Snobold in the
                                        // hand and its expiry releases it, see SetGUID
                                        snobold->CastSpell(me, SPELL_JUMP_TO_HAND, false);
                                        me->setAttackTimer(BASE_ATTACK, 3000);
                                        PlayerGUID = p->GetGUID();
                                    }

                                break;
                            }
                    events.Repeat(16s, 24s);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void SetGUID(ObjectGuid const& guid, int32 id) override
        {
            if (id != DATA_RELEASED_SNOBOLD)
                return;

            Creature* snobold = ObjectAccessor::GetCreature(*me, guid);
            if (!snobold)
                return;

            // Retail drops the Snobold 23 yards ahead of Gormok at hand height, even when he dies. The server
            // places a hand passenger at Gormok's own position, so measure from him.
            Position hand = me->GetPosition();
            hand.m_positionZ += 6.5f;
            Position dest = hand;
            dest.m_positionX += 23.0f * std::cos(me->GetOrientation());
            dest.m_positionY += 23.0f * std::sin(me->GetOrientation());
            me->GetMap()->GetMapCollisionData().GetStaticTree().GetObjectHitPos(hand.GetPositionX(), hand.GetPositionY(), hand.GetPositionZ(),
                dest.GetPositionX(), dest.GetPositionY(), dest.GetPositionZ(), dest.m_positionX, dest.m_positionY, dest.m_positionZ, -CONTACT_DISTANCE);

            snobold->DisableSpline();
            snobold->UpdatePosition(dest, true);

            Player* p = ObjectAccessor::GetPlayer(*me, PlayerGUID);
            PlayerGUID.Clear();

            if (!me->IsAlive())
            {
                snobold->GetMotionMaster()->MoveFall();
                return;
            }

            // A Fire Bomb started from the hand would block Rising Anger
            snobold->InterruptNonMeleeSpells(false);
            snobold->CastSpell(snobold, SPELL_RISING_ANGER, false);

            Vehicle* kit = p ? p->GetVehicleKit() : nullptr;
            if (kit && p->IsAlive() && !kit->GetPassenger(0) && !p->IsMounted() && !p->GetVehicle())
            {
                snobold->EnterVehicle(p, 0);
                snobold->AI()->SetGUID(p->GetGUID(), DATA_SNOBOLD_CARRIER);
            }
            else
            {
                snobold->GetMotionMaster()->MoveFall();
                snobold->AI()->DoAction(ACTION_SNOBOLD_MISSED);
            }
        }

        void JustDied(Unit* /*pKiller*/) override
        {
            summons.DoAction(ACTION_GORMOK_DIED);

            if (pInstance)
                pInstance->SetData(TYPE_GORMOK, DONE);
        }

        void JustSummoned(Creature* summon) override
        {
            summons.Summon(summon);
        }

        void DoAction(int32 param) override
        {
            switch (param)
            {
                case -1:
                    summons.DespawnAll();
                    break;
            }
        }

        void EnterEvadeMode(EvadeReason /*why*/) override
        {
            events.Reset();
            summons.DespawnAll();
            me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            if (pInstance)
                pInstance->SetData(TYPE_FAILED, 1);
        }
    };
};

// 66342 - Jump to Hand
class spell_gormok_jump_to_hand : public AuraScript
{
    PrepareAuraScript(spell_gormok_jump_to_hand);

    void HandleRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        AuraRemoveMode removeMode = GetTargetApplication()->GetRemoveMode();
        if (removeMode != AURA_REMOVE_BY_EXPIRE && removeMode != AURA_REMOVE_BY_DEATH)
            return;

        Unit* snobold = GetCaster();
        Creature* gormok = GetTarget()->ToCreature();
        if (!snobold || !snobold->IsAlive() || !gormok)
            return;

        // The ride aura from the Snobold's previous seat is still on Gormok; removing it later would eject the Snobold from its carrier
        if (removeMode == AURA_REMOVE_BY_EXPIRE)
            gormok->RemoveAurasByType(SPELL_AURA_CONTROL_VEHICLE, snobold->GetGUID());

        gormok->AI()->SetGUID(snobold->GetGUID(), DATA_RELEASED_SNOBOLD);
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(spell_gormok_jump_to_hand::HandleRemove, EFFECT_0, SPELL_AURA_CONTROL_VEHICLE, AURA_EFFECT_HANDLE_REAL);
    }
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
    SPELL_PARALYSIS                     = 66830,

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

    void DoAction(int32 param) override
    {
        switch (param)
        {
            case -1:
                if (!me->HasUnitFlag(UNIT_FLAG_NON_ATTACKABLE))
                    events.RescheduleEvent(EVENT_SUBMERGE, 1500ms);
                break;
            case -2:
                if (me->HasUnitFlag(UNIT_FLAG_NON_ATTACKABLE))
                    bIsStationary = true; // it will come out mobile soon
                else if (me->GetDisplayId() == _MODEL_STATIONARY )
                    events.RescheduleEvent(EVENT_SUBMERGE, 1s);
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
        if (me->GetDisplayId() == _MODEL_STATIONARY )
        {
            me->SetAttackTime(BASE_ATTACK, 1500);
            events.RescheduleEvent(EVENT_SPELL_SPRAY, (me->GetEntry() == NPC_ACIDMAW ? 20s : 15s));
            events.RescheduleEvent(EVENT_SPELL_SWEEP, 15s, 30s);
        }
        else
        {
            me->SetAttackTime(BASE_ATTACK, 2000);
            events.RescheduleEvent(EVENT_SPELL_BITE, (me->GetEntry() == NPC_ACIDMAW ? 20s : 15s));
            events.RescheduleEvent(EVENT_SPELL_SPEW, 15s, 30s);
            events.RescheduleEvent(EVENT_SPELL_SLIME_POOL, 15s);
        }
        if (!me->HasAura(SPELL_ENRAGE))
            events.RescheduleEvent(EVENT_SUBMERGE, 45s, 50s);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        me->setActive(true);
        ScheduleEvents();
    }

    void JustReachedHome() override
    {
        me->setActive(false);
    }

    void AttackStart(Unit* who) override
    {
        if (me->GetDisplayId() == _MODEL_STATIONARY )
        {
            if (!who)
                return;
            if (me->Attack(who, true))
                DoStartNoMovement(who);
        }
        else
            ScriptedAI::AttackStart(who);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        events.Update(diff);

        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        switch (events.ExecuteEvent())
        {
            case 0:
                break;
            case EVENT_SUBMERGE:
                {
                    bIsStationary = (me->GetDisplayId() == _MODEL_STATIONARY);
                    me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                    me->CastSpell(me, SPELL_SUBMERGE_0, false);

                    // second one submerge 1.5sec after the first one, used also for synchronizing
                    if (pInstance)
                        if (Creature* c = ObjectAccessor::GetCreature(*me, pInstance->GetGuidData(_TYPE_OTHER)))
                            c->AI()->DoAction(-1);

                    events.Reset();
                    events.RescheduleEvent(EVENT_MOVE_UNDERGROUND, 2500ms);
                }
                break;
            case EVENT_MOVE_UNDERGROUND:
                {
                    float angle = me->GetAngle(Locs[LOC_CENTER].GetPositionX() + urand(0, 20) - 10.0f, Locs[LOC_CENTER].GetPositionY() + urand(0, 20) - 10.0f), dist = urand(10, 35);
                    if (Creature* c = me->SummonCreature(NPC_WORLD_TRIGGER, *me, TEMPSUMMON_TIMED_DESPAWN, 6000))
                    {
                        c->SetSpeed(MOVE_RUN, 2.5f);
                        c->CastSpell(c, SPELL_CHURNING_GROUND, true);
                        c->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_PACIFIED);
                        c->GetMotionMaster()->MovePoint(0, Locs[LOC_CENTER].GetPositionX() + cos(angle)*dist, Locs[LOC_CENTER].GetPositionY() + std::sin(angle)*dist, me->GetPositionZ());
                    }
                    me->UpdatePosition(Locs[LOC_CENTER].GetPositionX() + cos(angle)*dist, Locs[LOC_CENTER].GetPositionY() + std::sin(angle)*dist, me->GetPositionZ(), me->GetOrientation(), true);
                    me->StopMovingOnCurrentPos();
                    DoResetThreatList();

                    events.RescheduleEvent(EVENT_EMERGE, 6s);
                }
                break;
            case EVENT_EMERGE:
                {
                    me->GetMotionMaster()->Clear();
                    me->GetMotionMaster()->MoveIdle();
                    me->StopMoving();
                    if (bIsStationary)
                    {
                        me->SetNativeDisplayId(_MODEL_MOBILE);
                        me->SetCombatMovement(true);
                        if (Unit* victim = me->GetVictim())
                            me->GetMotionMaster()->MoveChase(victim);
                    }
                    else
                    {
                        me->SetNativeDisplayId(_MODEL_STATIONARY);
                        me->SetCombatMovement(false);
                    }
                    me->RemoveAurasDueToSpell(SPELL_SUBMERGE_0);
                    me->CastSpell(me, SPELL_EMERGE_0, false);
                    me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                    ScheduleEvents();
                }
                break;
            case EVENT_SPELL_SPRAY:
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100.0f, true, false))
                    me->CastSpell(target, _SPELL_SPRAY, false);
                events.Repeat(20s);
                break;
            case EVENT_SPELL_SWEEP:
                me->CastSpell((Unit*)nullptr, SPELL_SWEEP_0, false);
                events.Repeat(15s, 30s);
                break;
            case EVENT_SPELL_BITE:
                if (Unit* victim = me->GetVictim())
                    me->CastSpell(victim, _SPELL_BITE, false);
                events.Repeat(20s);
                break;
            case EVENT_SPELL_SPEW:
                me->CastSpell(me->GetVictim(), _SPELL_SPEW, false);
                events.Repeat(15s, 30s);
                break;
            case EVENT_SPELL_SLIME_POOL:
                if (Creature* c = me->SummonCreature(NPC_SLIME_POOL, *me, TEMPSUMMON_TIMED_DESPAWN, 30000))
                    c->CastSpell(c, SPELL_SLIME_POOL_EFFECT, true);
                events.Repeat(30s);
                break;
        }

        if (!me->HasUnitFlag(UNIT_FLAG_NON_ATTACKABLE))
        {
            if (me->GetDisplayId() == _MODEL_STATIONARY )
                DoSpellAttackIfReady(_SPELL_SPIT);
            else
                DoMeleeAttackIfReady();
        }
    }

    void JustDied(Unit* /*pKiller*/) override
    {
        if (pInstance)
        {
            if (Creature* c = pInstance->instance->GetCreature(pInstance->GetGuidData(_TYPE_OTHER)))
                if (c->IsAlive())
                    c->AI()->DoAction(-2);
            pInstance->SetData(TYPE_JORMUNGAR, DONE);
        }
    }

    void EnterEvadeMode(EvadeReason /*why*/) override
    {
        events.Reset();
        me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
        if (pInstance)
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
            me->SetCombatMovement(false);
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetTrialOfTheCrusaderAI<boss_acidmawAI>(creature);
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

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetTrialOfTheCrusaderAI<boss_dreadscaleAI>(pCreature);
    }
};

// 66823, 67618, 67619, 67620 - Paralytic Toxin
class spell_jormungars_paralytic_toxin_aura : public AuraScript
{
    PrepareAuraScript(spell_jormungars_paralytic_toxin_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PARALYSIS });
    }

    void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* caster = GetCaster();
        if (caster && caster->GetEntry() == NPC_ACIDMAW)
            if (Creature* acidmaw = caster->ToCreature())
                acidmaw->AI()->Talk(WHISPER_PARALYTIC_TOXIN, GetTarget());
    }

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetTarget()->RemoveAurasDueToSpell(SPELL_PARALYSIS);
    }

    // Keeps the accumulated slow across amount recalculations
    void CalculateAmount(AuraEffect const* aurEff, int32& amount, bool& canBeRecalculated)
    {
        if (!canBeRecalculated)
            amount = aurEff->GetAmount();

        canBeRecalculated = false;
    }

    void HandlePeriodic(AuraEffect const* /*aurEff*/)
    {
        AuraEffect* slow = GetEffect(EFFECT_0);
        if (!slow)
            return;

        int32 newAmount = std::max(slow->GetAmount() - 10, -100);
        slow->ChangeAmount(newAmount);

        if (newAmount == -100 && !GetTarget()->HasAura(SPELL_PARALYSIS))
            GetTarget()->CastSpell(GetTarget(), SPELL_PARALYSIS, true, nullptr, slow, GetCasterGUID());
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_jormungars_paralytic_toxin_aura::OnApply, EFFECT_0, SPELL_AURA_MOD_DECREASE_SPEED, AURA_EFFECT_HANDLE_REAL);
        AfterEffectRemove += AuraEffectRemoveFn(spell_jormungars_paralytic_toxin_aura::OnRemove, EFFECT_0, SPELL_AURA_MOD_DECREASE_SPEED, AURA_EFFECT_HANDLE_REAL);
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_jormungars_paralytic_toxin_aura::CalculateAmount, EFFECT_0, SPELL_AURA_MOD_DECREASE_SPEED);
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_jormungars_paralytic_toxin_aura::HandlePeriodic, EFFECT_2, SPELL_AURA_PERIODIC_DUMMY);
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
    SPELL_ROAR                          = 66736,
    SPELL_JUMP_BACK                     = 66733,
    SPELL_TRAMPLE                       = 66734,
    SPELL_FROTHING_RAGE                 = 66759,
    SPELL_STAGGERED_DAZE                = 66758,
    SPELL_BERSERK                       = 26662,
    SPELL_SURGE_OF_ADRENALINE           = 68667,
};

enum IcehowlNPCs
{
    NPC_FURIOUS_CHARGE_STALKER          = 35062,
};

enum IcehowlPoints
{
    POINT_ICEHOWL_MIDDLE                = 1,
};

enum IcehowlEvents
{
    EVENT_JUMP_MIDDLE = 1,
    EVENT_GAZE,
    EVENT_ROAR,
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

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetTrialOfTheCrusaderAI<boss_icehowlAI>(pCreature);
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
        ObjectGuid StalkerGUID;
        float destX, destY, destZ;

        void AttackStart(Unit* who) override
        {
            if (me->GetReactState() != REACT_PASSIVE)
                ScriptedAI::AttackStart(who);
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            me->setActive(true);
            events.Reset();
            events.ScheduleEvent(EVENT_SPELL_FEROCIOUS_BUTT, 15s, 30s);
            events.RescheduleEvent(EVENT_SPELL_WHIRL, 10s, 12s);
            events.RescheduleEvent(EVENT_SPELL_ARCTIC_BREATH, 14s);
            events.RescheduleEvent(EVENT_JUMP_MIDDLE, 35s);
        }

        void JustReachedHome() override
        {
            me->setActive(false);
        }

        bool DoTrampleIfValid()
        {
            Map::PlayerList const& lPlayers = me->GetMap()->GetPlayers();
            for( Map::PlayerList::const_iterator itr = lPlayers.begin(); itr != lPlayers.end(); ++itr )
                if (Unit* p = itr->GetSource())
                    if (p->IsAlive() && p->GetExactDist(me) <= 12.0f )
                    {
                        DoCastAOE(SPELL_TRAMPLE);
                        return true;
                    }

            return false;
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type == EFFECT_MOTION_TYPE && id == POINT_ICEHOWL_MIDDLE)
                events.RescheduleEvent(EVENT_SPELL_MASSIVE_CRASH, 900ms);
            else if (id == EVENT_CHARGE)
            {
                events.Reset();
                events.RescheduleEvent(EVENT_SPELL_FEROCIOUS_BUTT, 5s, 15s);
                events.RescheduleEvent(EVENT_SPELL_WHIRL, 2s, 5s);
                events.RescheduleEvent(EVENT_SPELL_ARCTIC_BREATH, 5s, 8s);
                events.RescheduleEvent(EVENT_JUMP_MIDDLE, 30s, 50s);

                float angle = me->GetAngle(&Locs[LOC_CENTER]);
                angle = angle >= M_PI ? angle - M_PI : angle + M_PI;

                me->UpdatePosition(destX, destY, destZ, angle, true);
                me->StopMovingOnCurrentPos();

                if (!DoTrampleIfValid())
                {
                    me->CastSpell(me, SPELL_STAGGERED_DAZE, true);
                    me->CastSpell((Unit*)nullptr, SPELL_TRAMPLE, true);
                    Talk(EMOTE_TRAMPLE_CRASH);
                    events.DelayEvents(15s);
                }
                else
                {
                    Talk(EMOTE_TRAMPLE_FAIL);
                    me->CastSpell(me, SPELL_FROTHING_RAGE, true);
                }

                me->SetReactState(REACT_AGGRESSIVE);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case 0:
                    break;
                case EVENT_SPELL_FEROCIOUS_BUTT:
                    if (Unit* victim = me->GetVictim())
                        me->CastSpell(victim, SPELL_FEROCIOUS_BUTT, false);
                    events.Repeat(15s, 30s);
                    break;
                case EVENT_SPELL_WHIRL:
                    me->CastSpell((Unit*)nullptr, SPELL_WHIRL, false);
                    events.Repeat(15s, 20s);
                    break;
                case EVENT_SPELL_ARCTIC_BREATH:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 90.0f, true))
                        me->CastSpell(target, SPELL_ARCTIC_BREATH, false);
                    events.Repeat(20s, 30s);
                    break;
                case EVENT_JUMP_MIDDLE:
                    me->StopMoving();
                    me->GetMotionMaster()->Clear();
                    me->GetMotionMaster()->MoveIdle();
                    me->SetReactState(REACT_PASSIVE);
                    me->AttackStop();
                    events.Reset();
                    me->GetMotionMaster()->MoveJump(Locs[LOC_CENTER].GetPositionX(), Locs[LOC_CENTER].GetPositionY(), Locs[LOC_CENTER].GetPositionZ(), 40.0f, 12.0f, POINT_ICEHOWL_MIDDLE);
                    me->SetGuidValue(UNIT_FIELD_TARGET, ObjectGuid::Empty);
                    break;
                case EVENT_SPELL_MASSIVE_CRASH:
                    me->GetMotionMaster()->Clear();
                    me->CastSpell((Unit*)nullptr, SPELL_MASSIVE_CRASH, false);

                    events.RescheduleEvent(EVENT_GAZE, 3900ms);
                    break;
                case EVENT_GAZE:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 500.0f, true))
                    {
                        me->SetGuidValue(UNIT_FIELD_TARGET, target->GetGUID());
                        Talk(EMOTE_TRAMPLE_STARE, target);

                        // The charge runs through the glared position and on into the arena wall
                        float angle = Locs[LOC_CENTER].GetAngle(target);
                        float dist = 50.0f;
                        if (angle > 1.0f && angle < 2.0f) // near main gate
                            dist = 46.0f;
                        destX = Locs[LOC_CENTER].GetPositionX() + cos(angle) * dist;
                        destY = Locs[LOC_CENTER].GetPositionY() + std::sin(angle) * dist;
                        destZ = Locs[LOC_CENTER].GetPositionZ() + 1.0f;

                        if (Creature* stalker = me->SummonCreature(NPC_FURIOUS_CHARGE_STALKER, *target, TEMPSUMMON_TIMED_DESPAWN, 20000))
                        {
                            StalkerGUID = stalker->GetGUID();
                            me->SetFacingToObject(stalker);
                        }

                        events.RescheduleEvent(EVENT_ROAR, 1800ms);
                    }
                    else // in case something went wrong
                    {
                        events.RescheduleEvent(EVENT_SPELL_FEROCIOUS_BUTT, 5s, 15s);
                        events.RescheduleEvent(EVENT_SPELL_WHIRL, 2s, 5s);
                        events.RescheduleEvent(EVENT_SPELL_ARCTIC_BREATH, 5s, 8s);
                        events.RescheduleEvent(EVENT_JUMP_MIDDLE, 30s, 50s);
                        me->GetMotionMaster()->MovementExpired();
                        me->SetReactState(REACT_AGGRESSIVE);
                    }

                    break;
                case EVENT_ROAR:
                    if (Creature* stalker = ObjectAccessor::GetCreature(*me, StalkerGUID))
                        DoCast(stalker, SPELL_ROAR);
                    events.RescheduleEvent(EVENT_JUMP_BACK, 2800ms);
                    break;
                case EVENT_JUMP_BACK:
                    if (Creature* stalker = ObjectAccessor::GetCreature(*me, StalkerGUID))
                    {
                        me->SetFacingToObject(stalker);
                        DoCast(stalker, SPELL_JUMP_BACK);
                    }
                    events.RescheduleEvent(EVENT_TRAMPLE, 2s);
                    break;
                case EVENT_TRAMPLE:
                    //Talk(EMOTE_TRAMPLE_START);
                    me->DisableSpline();
                    me->GetMotionMaster()->Clear();
                    me->GetMotionMaster()->MoveCharge(destX, destY, destZ + 1.0f, 65.0f);
                    me->SetGuidValue(UNIT_FIELD_TARGET, ObjectGuid::Empty);
                    events.RescheduleEvent(EVENT_CHECK_TRAMPLE_PLAYERS, 100ms);

                    break;
                case EVENT_CHECK_TRAMPLE_PLAYERS:
                    if (DoTrampleIfValid())
                    {
                        events.Reset();
                        events.RescheduleEvent(EVENT_SPELL_FEROCIOUS_BUTT, 5s, 15s);
                        events.RescheduleEvent(EVENT_SPELL_WHIRL, 2s, 5s);
                        events.RescheduleEvent(EVENT_SPELL_ARCTIC_BREATH, 5s, 8s);
                        events.RescheduleEvent(EVENT_JUMP_MIDDLE, 30s, 50s);
                        Talk(EMOTE_TRAMPLE_FAIL);
                        me->CastSpell(me, SPELL_FROTHING_RAGE, true);
                        me->GetMotionMaster()->MovementExpired();
                        me->SetReactState(REACT_AGGRESSIVE);
                    }
                    else
                        events.Repeat(100ms);
                    break;
                case EVENT_REFRESH_POSITION:
                    //me->SetFacingTo(me->GetOrientation());

                    break;
            }

            if (me->GetReactState() != REACT_PASSIVE )
                DoMeleeAttackIfReady();
        }

        void EnterEvadeMode(EvadeReason /*why*/) override
        {
            events.Reset();
            me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            if (pInstance)
                pInstance->SetData(TYPE_FAILED, 1);
        }

        void JustDied(Unit* /*killer*/) override
        {
            if (!pInstance)
                return;

            pInstance->SetData(TYPE_ICEHOWL, DONE);
        }
    };
};

// 66733 - Jump Back
class spell_icehowl_jump_back : public SpellScript
{
    PrepareSpellScript(spell_icehowl_jump_back);

    // The default handler leaps non-hunter spells forward and pads the distance with the caster's combat reach
    void HandleLeapBack(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);

        Unit* target = GetHitUnit();
        if (!target)
            return;

        float speedXY = GetSpellInfo()->Effects[effIndex].MiscValue / 10.0f;
        float speedZ = GetEffectValue() / 10.0f;
        float dist = 2.0f * speedZ / Movement::gravity * speedXY;
        Position dest = target->GetFirstCollisionPosition(dist, M_PI);
        target->GetMotionMaster()->MoveJump(dest.GetPositionX(), dest.GetPositionY(), dest.GetPositionZ(), speedXY, speedZ, 0, GetExplTargetUnit());
    }

    void Register() override
    {
        OnEffectLaunchTarget += SpellEffectFn(spell_icehowl_jump_back::HandleLeapBack, EFFECT_1, SPELL_EFFECT_LEAP_BACK);
    }
};

// 66683, 67660, 67661, 67662 - Massive Crash
class spell_icehowl_massive_crash : public AuraScript
{
    PrepareAuraScript(spell_icehowl_massive_crash);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SURGE_OF_ADRENALINE });
    }

    void HandleRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        if (target->IsPlayer() && !target->GetMap()->IsHeroic())
            target->CastSpell(target, SPELL_SURGE_OF_ADRENALINE, true);
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(spell_icehowl_massive_crash::HandleRemove, EFFECT_2, SPELL_AURA_MOD_STUN, AURA_EFFECT_HANDLE_REAL);
    }
};

void AddSC_boss_northrend_beasts()
{
    new boss_gormok();
    new npc_snobold_vassal();
    RegisterSpellScript(spell_gormok_jump_to_hand);

    new boss_acidmaw();
    new boss_dreadscale();
    RegisterSpellScript(spell_jormungars_paralytic_toxin_aura);

    new boss_icehowl();
    RegisterSpellScript(spell_icehowl_jump_back);
    RegisterSpellScript(spell_icehowl_massive_crash);
}
