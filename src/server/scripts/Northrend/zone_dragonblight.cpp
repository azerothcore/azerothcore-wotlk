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
#include "CellImpl.h"
#include "Chat.h"
#include "CombatAI.h"
#include "CreatureScript.h"
#include "CreatureTextMgr.h"
#include "GameObjectScript.h"
#include "GridNotifiersImpl.h"
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellAuraEffects.h"
#include "SpellAuras.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "Vehicle.h"

// Ours
/********
QUEST Conversing With the Depths (12032)
********/

enum DepthsMisc
{
    QUEST_CONVERSING_WITH_THE_DEPTHS        = 12032,
    DEEPDIVING_PEARL_BUFF                   = 41273,
    NPC_OACHANOA                            = 26648,
    NPC_CONVERSING_WITH_THE_DEPTHS_TRIGGER  = 70100,
};

enum DepthsTexts
{
    // Oacha'noa being summoned
    SAY_OACHANOA_SUMMONED_0                 = 0,
    SAY_OACHANOA_SUMMONED_1                 = 1,
    SAY_OACHANOA_SUMMONED_2                 = 2,
    SAY_OACHANOA_SUMMONED_3                 = 3,
    //SAY_OACHANOA_SUMMONED_4                 = 4, // Unused(no source) and no BroadcastTextId

    // If success
    SAY_OACHANOA_SUCCESS                    = 5,
    WHISPER_OACHANOA_SUCCESS_0              = 6,
    WHISPER_OACHANOA_SUCCESS_1              = 7,
    WHISPER_OACHANOA_SUCCESS_2              = 8,

    // If failed
    SAY_OACHANOA_FAILED                     = 9,
};

class npc_conversing_with_the_depths_trigger : public CreatureScript
{
public:
    npc_conversing_with_the_depths_trigger() : CreatureScript("npc_conversing_with_the_depths_trigger") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return new npc_conversing_with_the_depths_triggerAI (pCreature);
    }

    struct npc_conversing_with_the_depths_triggerAI : public ScriptedAI
    {
        npc_conversing_with_the_depths_triggerAI(Creature* c) : ScriptedAI(c) { }

        bool running;
        bool secondpart;
        bool canjump;
        int32 timer;
        uint8 step;
        ObjectGuid pGUID;
        ObjectGuid oachanoaGUID;

        Creature* GetOachanoa() {return ObjectAccessor::GetCreature(*me, oachanoaGUID);}
        Player* GetPlayer() {return ObjectAccessor::GetPlayer(*me, pGUID);}

        void Reset() override
        {
            running = false;
            secondpart = false;
            canjump = false;
            timer = 0;
            step = 0;
            pGUID.Clear();
            oachanoaGUID.Clear();
        }

        void NextStep(const uint32 time)
        {
            step++;
            timer = time;
        }

        void DespawnOachanoa()
        {
            if (Creature* c = GetOachanoa())
                c->DespawnOrUnsummon();
        }

        void UpdateAI(uint32 diff) override
        {
            if (running)
            {
                if (Player* p = GetPlayer())
                    if (p->GetPositionZ() < 1.0f && !secondpart)  // Player is in the water
                    {
                        if (p->HasAura(DEEPDIVING_PEARL_BUFF) && canjump)
                        {
                            NextStep(500);
                            secondpart = true;
                        }
                        else // Despawn and fail quest if player jumps too early
                        {
                            p->SendQuestFailed(QUEST_CONVERSING_WITH_THE_DEPTHS);
                            DespawnOachanoa();
                            Reset();
                        }
                    }

                if (timer != 0)
                {
                    timer -= diff;
                    if (timer < 0)
                        timer = 0;
                }
                else
                    switch (step)
                    {
                        case 0:
                            NextStep(10000);
                            break;
                        case 1: // Oacha'noa being summoned
                            {
                                Creature* c = me->SummonCreature(NPC_OACHANOA, 2406.24f, 1701.98f, 0.1f, 0.3f, TEMPSUMMON_TIMED_DESPAWN, 90000, 0);
                                if (!c)
                                {
                                    Reset();
                                    return;
                                }
                                c->SetCanFly(true);
                                c->GetMotionMaster()->MovePoint(0, 2406.25f, 1701.98f, 0.1f);
                                oachanoaGUID = c->GetGUID();

                                NextStep(3000);
                                break;
                            }
                        case 2:
                            {
                                Player* p = GetPlayer();
                                if (!p)
                                {
                                    Reset();
                                    return;
                                }
                                if (Creature* c = GetOachanoa())
                                    c->AI()->Talk(SAY_OACHANOA_SUMMONED_0, p);

                                NextStep(6000);
                                break;
                            }
                        case 3:
                            {
                                if (Creature* c = GetOachanoa())
                                    c->AI()->Talk(SAY_OACHANOA_SUMMONED_1);

                                NextStep(6000);
                                break;
                            }
                        case 4:
                            {
                                if (Creature* c = GetOachanoa())
                                    c->AI()->Talk(SAY_OACHANOA_SUMMONED_2);
                                Player* p = GetPlayer();
                                if (!p)
                                {
                                    Reset();
                                    return;
                                }
                                p->CastSpell(p, DEEPDIVING_PEARL_BUFF, true);

                                NextStep(6000);
                                break;
                            }
                        case 5: // 20s countdown starts, the player can jump now
                            {
                                canjump = true;
                                if (Creature* c = GetOachanoa())
                                    c->AI()->Talk(SAY_OACHANOA_SUMMONED_3);

                                NextStep(20500);
                                break;
                            }
                        case 6: // If failed (player DOESN'T jump within 20 seconds)
                            {
                                Player* p = GetPlayer();
                                if (Creature* c = GetOachanoa())
                                    c->AI()->Talk(SAY_OACHANOA_FAILED, p);

                                DespawnOachanoa();
                                Reset();
                                break;
                            }
                        case 7: // If success (player jumps)
                            {
                                Player* p = GetPlayer();
                                if (!p)
                                {
                                    Reset();
                                    return;
                                }
                                if (Creature* c = GetOachanoa())
                                    c->AI()->Talk(SAY_OACHANOA_SUCCESS, p);

                                NextStep(6000);
                                break;
                            }
                        case 8:
                            {
                                Player* p = GetPlayer();
                                if (Creature* c = GetOachanoa())
                                    c->AI()->Talk(WHISPER_OACHANOA_SUCCESS_0, p);

                                NextStep(6000);
                                break;
                            }
                        case 9:
                            {
                                Player* p = GetPlayer();
                                if (Creature* c = GetOachanoa())
                                    c->AI()->Talk(WHISPER_OACHANOA_SUCCESS_1, p);

                                NextStep(6000);
                                break;
                            }
                        case 10:
                            {
                                Player* p = GetPlayer();
                                if (!p)
                                {
                                    Reset();
                                    return;
                                }

                                if (Creature* c = GetOachanoa())
                                    c->AI()->Talk(WHISPER_OACHANOA_SUCCESS_2, p);

                                p->AreaExploredOrEventHappens(QUEST_CONVERSING_WITH_THE_DEPTHS);

                                DespawnOachanoa();
                                Reset();
                            }
                    }
            }
        }

        void Start(ObjectGuid g)
        {
            running = true;
            pGUID = g;
        }
    };
};

class go_the_pearl_of_the_depths : public GameObjectScript
{
public:
    go_the_pearl_of_the_depths() : GameObjectScript("go_the_pearl_of_the_depths") { }

    bool OnGossipHello(Player* player, GameObject* go) override
    {
        if (!player || !go)
            return true;

        Creature* t = player->FindNearestCreature(NPC_CONVERSING_WITH_THE_DEPTHS_TRIGGER, 10.0f, true);
        if (t && t->AI() && CAST_AI(npc_conversing_with_the_depths_trigger::npc_conversing_with_the_depths_triggerAI, t->AI()))
            if (!CAST_AI(npc_conversing_with_the_depths_trigger::npc_conversing_with_the_depths_triggerAI, t->AI())->running)
                CAST_AI(npc_conversing_with_the_depths_trigger::npc_conversing_with_the_depths_triggerAI, t->AI())->Start(player->GetGUID());

        return true;
    }
};

enum hourglass
{
    NPC_FUTURE_HOURGLASS                    = 27840,
    NPC_FUTURE_YOU                          = 27899,

    NPC_PAST_HOURGLASS                      = 32327,
    NPC_PAST_YOU                            = 32331,

    NPC_INFINITE_ASSAILANT                  = 27896,
    NPC_INFINITE_CHRONO_MAGUS               = 27898,
    NPC_INFINITE_DESTROYER                  = 27897,
    NPC_INFINITE_TIMERENDER                 = 27900,
    NPC_NOZDORMU                            = 27925,

    SPELL_NOZDORMU_INVIS                    = 50013,
    SPELL_CLONE_CASTER                      = 49889,
    SPELL_TELEPORT_EFFECT                   = 52096,

    EVENT_START_EVENT                       = 1,
    EVENT_FIGHT_1                           = 2,
    EVENT_FIGHT_2                           = 3,
    EVENT_CHECK_FINISH                      = 4,
    EVENT_FINISH_EVENT                      = 5,

    QUEST_MYSTERY_OF_THE_INFINITE           = 12470,
    QUEST_MYSTERY_OF_THE_INFINITE_REDUX     = 13343,
};

enum hourglassText
{
    // (All are whispers) Both NPC_PAST_YOU and NPC_FUTURE_YOU share the same creature_text GroupIDs
    // Start
    SAY_HOURGLASS_START_1                   = 1,
    SAY_HOURGLASS_START_2                   = 2,

    // Random whispers during the fight
    SAY_HOURGLASS_RANDOM_1                  = 3,
    SAY_HOURGLASS_RANDOM_2                  = 4,
    SAY_HOURGLASS_RANDOM_3                  = 5,
    SAY_HOURGLASS_RANDOM_4                  = 6,
    SAY_HOURGLASS_RANDOM_5                  = 7,
    SAY_HOURGLASS_RANDOM_6                  = 8,
    SAY_HOURGLASS_RANDOM_7                  = 9,
    SAY_HOURGLASS_RANDOM_8                  = 10,

    // End
    SAY_HOURGLASS_END_1                     = 11,
    SAY_HOURGLASS_END_2                     = 12,
};

class npc_hourglass_of_eternity : public CreatureScript
{
public:
    npc_hourglass_of_eternity() : CreatureScript("npc_hourglass_of_eternity") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return new npc_hourglass_of_eternityAI (pCreature);
    }

    struct npc_hourglass_of_eternityAI : public ScriptedAI
    {
        npc_hourglass_of_eternityAI(Creature* c) : ScriptedAI(c) {}

        ObjectGuid pGUID;
        ObjectGuid copyGUID;
        EventMap events;
        uint8 count[3];
        uint8 phase;
        uint8 randomTalk;
        uint8 lastRandomTalk;

        bool IsFuture() {return me->GetEntry() == NPC_FUTURE_HOURGLASS;}
        void InitializeAI() override
        {
            if (me->ToTempSummon())
                if (Unit* summoner = me->ToTempSummon()->GetSummonerUnit())
                {
                    pGUID = summoner->GetGUID();
                    float x, y, z;
                    me->GetNearPoint(summoner, x, y, z, me->GetCombatReach(), 0.0f, rand_norm() * 2 * M_PI);
                    if (Creature* cr = summoner->SummonCreature((IsFuture() ? NPC_FUTURE_YOU : NPC_PAST_YOU), x, y, z, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 210000))
                    {
                        copyGUID = cr->GetGUID();
                        summoner->CastSpell(cr, SPELL_CLONE_CASTER, true);
                        cr->SetFaction(summoner->GetFaction());
                        cr->SetReactState(REACT_AGGRESSIVE);
                    }
                }

            count[0] = 2;
            count[1] = 2;
            count[2] = 3;

            phase = 0;
            events.Reset();
            events.ScheduleEvent(EVENT_START_EVENT, 4s);
        }

        Player* GetPlayer() {return ObjectAccessor::GetPlayer(*me, pGUID);}
        Creature* GetCopy() {return ObjectAccessor::GetCreature(*me, copyGUID);}

        uint32 randEntry()
        {
            return NPC_INFINITE_ASSAILANT + urand(0, 2);
        }

        void ShowNozdormu()
        {
            if (Creature* cr = me->FindNearestCreature(NPC_NOZDORMU, 100.0f, true))
                cr->RemoveAura(SPELL_NOZDORMU_INVIS);
        }

        void HideNozdormu()
        {
            if (Creature* cr = me->FindNearestCreature(NPC_NOZDORMU, 100.0f, true))
                cr->AddAura(SPELL_NOZDORMU_INVIS, cr);
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);
            switch (events.ExecuteEvent())
            {
                case EVENT_START_EVENT:
                    if (Creature* cr = GetCopy())
                        cr->AI()->Talk(SAY_HOURGLASS_START_1, GetPlayer());
                    events.ScheduleEvent(EVENT_FIGHT_1, 7s);
                    break;
                case EVENT_FIGHT_1:
                    if (Creature* cr = GetCopy())
                        cr->AI()->Talk(SAY_HOURGLASS_START_2, GetPlayer());
                    events.ScheduleEvent(EVENT_FIGHT_2, 6s);
                    break;
                case EVENT_FIGHT_2:
                    {
                        if (phase)
                            randomWhisper();

                        Creature* cr = nullptr;
                        float x, y, z;
                        if (phase < 3)
                        {
                            for (uint8 i = 0; i < count[phase]; ++i)
                            {
                                me->GetNearPoint(me, x, y, z, me->GetCombatReach(), 10.0f, rand_norm() * 2 * M_PI);
                                if ((cr = me->SummonCreature(randEntry(), x, y, z + 2.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000)))
                                {
                                    cr->CastSpell(cr, SPELL_TELEPORT_EFFECT, true);
                                    cr->AI()->AttackStart(me);
                                    cr->AddThreat(me, 100.0f);
                                }
                            }
                        }
                        else if (phase == 3)
                        {
                            me->GetNearPoint(me, x, y, z, me->GetCombatReach(), 20.0f, rand_norm() * 2 * M_PI);
                            if ((cr = me->SummonCreature(NPC_INFINITE_TIMERENDER, x, y, z, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000)))
                            {
                                cr->CastSpell(cr, SPELL_TELEPORT_EFFECT, true);
                                cr->AI()->AttackStart(me);
                            }

                            events.ScheduleEvent(EVENT_CHECK_FINISH, 20s);
                            return;
                        }

                        ++phase;
                        events.ScheduleEvent(EVENT_FIGHT_2, 35s);
                        break;
                    }
                case EVENT_CHECK_FINISH:
                    {
                        if (me->FindNearestCreature(NPC_INFINITE_TIMERENDER, 50.0f))
                        {
                            events.Repeat(5s);
                            return;
                        }

                        ShowNozdormu();
                        if (Player* player = GetPlayer())
                            player->GroupEventHappens(IsFuture() ? QUEST_MYSTERY_OF_THE_INFINITE : QUEST_MYSTERY_OF_THE_INFINITE_REDUX, me);

                        if (Creature* cr = GetCopy())
                        {
                            cr->SetFacingToObject(me->FindNearestCreature(NPC_NOZDORMU, 100.0f, true));
                            cr->AI()->Talk(SAY_HOURGLASS_END_1, GetPlayer());
                        }
                        events.ScheduleEvent(EVENT_FINISH_EVENT, 6s);
                        break;
                    }
                case EVENT_FINISH_EVENT:
                    {
                        HideNozdormu();
                        if (Creature* cr = GetCopy())
                            cr->AI()->Talk(SAY_HOURGLASS_END_2, GetPlayer());
                        me->DespawnOrUnsummon(500);
                        if (GetCopy())
                            GetCopy()->DespawnOrUnsummon(500);
                        break;
                    }
            }
        }

        void randomWhisper() // Do not repeat the same line
        {
            randomTalk = urand(SAY_HOURGLASS_RANDOM_1, SAY_HOURGLASS_RANDOM_8); // 3 to 10
            if (randomTalk == lastRandomTalk)
            {
                randomWhisper();
            }
            else
            {
                if (Creature* cr = GetCopy())
                    cr->AI()->Talk(randomTalk, GetPlayer());
                lastRandomTalk = randomTalk;
            }
        }
    };
};

class npc_future_you : public CreatureScript
{
public:
    npc_future_you() : CreatureScript("npc_future_you") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return new npc_future_youAI (pCreature);
    }

    struct npc_future_youAI : public ScriptedAI
    {
        npc_future_youAI(Creature* c) : ScriptedAI(c) {}

        void EnterEvadeMode(EvadeReason /*why*/) override
        {
            me->RemoveUnitFlag(UNIT_FLAG_IN_COMBAT);
            me->ClearUnitState(UNIT_STATE_EVADE);
        }

        void Reset() override
        {
            if (me->ToTempSummon() && me->ToTempSummon()->GetSummonerUnit())
                me->SetFaction(me->ToTempSummon()->GetSummonerUnit()->GetFaction());
        }

        void MoveInLineOfSight(Unit* who) override
        {
            if (!me->GetVictim() && !who->IsFlying() && who->GetEntry() >= NPC_INFINITE_ASSAILANT && who->GetEntry() <= NPC_INFINITE_TIMERENDER)
                AttackStart(who);
        }

        void UpdateAI(uint32  /*diff*/) override
        {
            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }
    };
};

enum chainGun
{
    NPC_INJURED_7TH_LEGION_SOLDER               = 27788,
    SPELL_FEAR_AURA_WITH_COWER                  = 49774
};

class npc_mindless_ghoul : public CreatureScript
{
public:
    npc_mindless_ghoul() : CreatureScript("npc_mindless_ghoul") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return new npc_mindless_ghoulAI (pCreature);
    }

    struct npc_mindless_ghoulAI : public ScriptedAI
    {
        npc_mindless_ghoulAI(Creature* c) : ScriptedAI(c)
        {
            me->SetCorpseDelay(1);
        }

        bool CanAIAttack(Unit const* who) const override
        {
            return who->GetEntry() == NPC_INJURED_7TH_LEGION_SOLDER;
        }

        void JustDied(Unit*) override
        {
            me->SetCorpseDelay(1);
        }
    };
};

class npc_injured_7th_legion_soldier : public CreatureScript
{
public:
    npc_injured_7th_legion_soldier() : CreatureScript("npc_injured_7th_legion_soldier") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return new npc_injured_7th_legion_soldierAI (pCreature);
    }

    struct npc_injured_7th_legion_soldierAI : public NullCreatureAI
    {
        npc_injured_7th_legion_soldierAI(Creature* c) : NullCreatureAI(c) {}

        void Reset() override
        {
            me->CastSpell(me, SPELL_FEAR_AURA_WITH_COWER, true);
            me->SetWalk(false);
            uint32 path = me->GetEntry() * 10 + urand(0, 4);
            if (me->GetPositionY() > -1150.0f)
                path += 5;
            me->GetMotionMaster()->MovePath(path, false);
        }

        void MovementInform(uint32 type, uint32 point) override
        {
            if (type != WAYPOINT_MOTION_TYPE)
                return;

            if (point == 8) // max-1
            {
                Talk(0);
                me->RemoveAllAuras();
                me->DespawnOrUnsummon(1000);
                if (TempSummon* summon = me->ToTempSummon())
                    if (Unit* owner = summon->GetSummonerUnit())
                        if (Player* player = owner->ToPlayer())
                            player->KilledMonsterCredit(me->GetEntry());
            }
        }
    };
};

enum WintergardeGryphon
{
    SPELL_RESCUE_VILLAGER                       = 48363,
    SPELL_DROP_OFF_VILLAGER                     = 48397,
    SPELL_RIDE_VEHICLE                          = 43671,

    NPC_HELPLESS_VILLAGER_A                     = 27315,
    NPC_HELPLESS_VILLAGER_B                     = 27336,

    EVENT_VEHICLE_GET                           = 1,
    EVENT_TAKE_OFF                              = 2,
    EVENT_GET_VILLAGER                          = 3,

    EVENT_PHASE_FEAR                            = 1,
    EVENT_PHASE_VEHICLE                         = 2,

    POINT_LAND                                  = 1,
    POINT_TAKE_OFF                              = 2,

    QUEST_FLIGHT_OF_THE_WINTERGARDE_DEFENDER    = 12237,
    GO_TEMP_GRYPHON_STATION                     = 188679,
    AREA_WINTERGARDE_KEEP                       = 4177
};

class npc_wintergarde_gryphon : public VehicleAI
{
public:
    npc_wintergarde_gryphon(Creature* creature) : VehicleAI(creature)
    {
        creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
    }

    void JustDied(Unit* /*killer*/) override
    {
        me->DespawnOrUnsummon(3s, 0s);
    }

    void IsSummonedBy(WorldObject* summoner) override
    {
        me->SetFacingToObject(summoner);
        Position pos = summoner->GetPosition();
        me->GetMotionMaster()->MovePoint(POINT_LAND, pos);
    }

    void MovementInform(uint32 type, uint32 id) override
    {
        if (type == POINT_MOTION_TYPE && id == POINT_LAND)
            events.ScheduleEvent(EVENT_VEHICLE_GET, 0s);
    }

    void PassengerBoarded(Unit* passenger, int8 seatId, bool apply) override
    {
        if (!apply && seatId == 0)
        {
            // left the vehicle with a passenger will result in despawn
            if (Vehicle* gryphon = me->GetVehicleKit())
                if (Unit* villager = gryphon->GetPassenger(1))
                {
                    if (!villager->IsCreature())
                        return;

                    if (Creature* seat = villager->ToCreature())
                    {
                        seat->ExitVehicle();
                        seat->DespawnOrUnsummon();
                    }
                }

            events.ScheduleEvent(EVENT_TAKE_OFF, 2s);
            me->CastSpell(passenger, VEHICLE_SPELL_PARACHUTE, true);
        }
    }

    Creature* getVillager() { return ObjectAccessor::GetCreature(*me, villagerGUID); }

    void UpdateAI(uint32 diff) override
    {
        events.Update(diff);
        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_VEHICLE_GET:
                {
                    me->SetDisableGravity(false);
                    me->SetHover(false);
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                    break;
                }
                case EVENT_TAKE_OFF:
                {
                    me->DespawnOrUnsummon(4050);
                    me->SetOrientation(2.5f);
                    me->SetSpeedRate(MOVE_FLIGHT, 1.0f);
                    Position pos = me->GetPosition();
                    Position offset = { 14.0f, 14.0f, 16.0f, 0.0f };
                    pos.RelocateOffset(offset);
                    me->GetMotionMaster()->MovePoint(POINT_TAKE_OFF, pos);
                    break;
                }
                case EVENT_GET_VILLAGER:
                {
                    if (getVillager())
                    {
                        getVillager()->GetMotionMaster()->MovePoint(0, 3660.0f, -706.4f, 215.0f);
                        getVillager()->DespawnOrUnsummon(7s, 0s);
                    }
                    break;
                }
            }
        }
    }

    void SpellHit(Unit* /*caster*/, SpellInfo const* spell) override
    {
        if (spell->Id != SPELL_DROP_OFF_VILLAGER)
            return;

        if (Vehicle* gryphon = me->GetVehicleKit())
            if (Unit* villager = gryphon->GetPassenger(1))
            {
                villager->ExitVehicle();
                villager->GetMotionMaster()->Clear(false);
                villager->GetMotionMaster()->MoveIdle();
                villager->SetCanFly(false); // prevents movement in flight
                villagerGUID = villager->GetGUID();
                villager->HandleEmoteCommand(EMOTE_ONESHOT_CHEER);
                events.ScheduleEvent(EVENT_GET_VILLAGER, 3s);
            }
    }
private:
    ObjectGuid villagerGUID;
};

class spell_q12237_rescue_villager : public SpellScript
{
    PrepareSpellScript(spell_q12237_rescue_villager);

    SpellCastResult CheckCast()
    {
        Player* owner = GetCaster()->GetCharmerOrOwnerPlayerOrPlayerItself();

        if (!owner)
            return SPELL_FAILED_DONT_REPORT;

        SpellCustomErrors extension = SPELL_CUSTOM_ERROR_NONE;
        SpellCastResult result = SPELL_CAST_OK;

        if (GetCaster()->GetAreaId() == AREA_WINTERGARDE_KEEP)
        {
            extension = SPELL_CUSTOM_ERROR_MUST_BE_NEAR_HELPLESS_VILLAGER;
            result = SPELL_FAILED_CUSTOM_ERROR;
        }

        if (!GetCaster()->FindNearestCreature(NPC_HELPLESS_VILLAGER_A, 5.0f) && !GetCaster()->FindNearestCreature(NPC_HELPLESS_VILLAGER_B, 5.0f))
        {
            extension = SPELL_CUSTOM_ERROR_MUST_BE_NEAR_HELPLESS_VILLAGER;
            result = SPELL_FAILED_CUSTOM_ERROR;
        }

        if (GetCaster()->FindNearestGameObject(GO_TEMP_GRYPHON_STATION, 15.0f))
        {
            extension = SPELL_CUSTOM_ERROR_NEED_HELPLESS_VILLAGER;
            result = SPELL_FAILED_CUSTOM_ERROR;
        }

        if (GetCaster()->HasAura(SPELL_RIDE_VEHICLE))
            result = SPELL_FAILED_CANT_DO_THAT_RIGHT_NOW;

        if (result != SPELL_CAST_OK)
        {
            Spell::SendCastResult(owner, GetSpellInfo(), 0, result, extension);
            return result;
        }

        return SPELL_CAST_OK;
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
            target->CastSpell(GetCaster(), uint32(GetEffectValue()), true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_q12237_rescue_villager::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        OnCheckCast += SpellCheckCastFn(spell_q12237_rescue_villager::CheckCast);
    }
};

class spell_q12237_drop_off_villager : public SpellScript
{
    PrepareSpellScript(spell_q12237_drop_off_villager);

    SpellCastResult CheckCast()
    {
        Player* master = GetCaster()->GetCharmerOrOwnerPlayerOrPlayerItself();

        if (!master)
            return SPELL_FAILED_DONT_REPORT;

        SpellCustomErrors extension = SPELL_CUSTOM_ERROR_NONE;
        SpellCastResult result = SPELL_CAST_OK;

        if (!GetCaster()->FindNearestGameObject(GO_TEMP_GRYPHON_STATION, 10.0f))
            result = SPELL_FAILED_REQUIRES_SPELL_FOCUS;

        if (!GetCaster()->HasAura(SPELL_RIDE_VEHICLE))
        {
            extension = SPELL_CUSTOM_ERROR_NO_PASSENGER;
            result = SPELL_FAILED_CUSTOM_ERROR;
        }

        if (result != SPELL_CAST_OK)
        {
            Spell::SendCastResult(master, GetSpellInfo(), 0, result, extension);
            return result;
        }

        return SPELL_CAST_OK;
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_q12237_drop_off_villager::CheckCast);
    }
};

class spell_call_wintergarde_gryphon : public SpellScript
{
    PrepareSpellScript(spell_call_wintergarde_gryphon);

    void SetDest(SpellDestination& dest)
    {
        // Adjust effect summon position
        Position const offset = { 0.0f, 0.0f, 9.0f, 0.0f };
        dest.RelocateOffset(offset);
    }

    SpellCastResult CheckRequirement()
    {
        if (Player* playerCaster = GetCaster()->ToPlayer())
        {
            if (playerCaster->GetQuestStatus(QUEST_FLIGHT_OF_THE_WINTERGARDE_DEFENDER) == QUEST_STATUS_INCOMPLETE)
                return SPELL_CAST_OK;
        }
        return SPELL_FAILED_DONT_REPORT;
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_call_wintergarde_gryphon::CheckRequirement);
        OnDestinationTargetSelect += SpellDestinationTargetSelectFn(spell_call_wintergarde_gryphon::SetDest, EFFECT_0, TARGET_DEST_CASTER_FRONT);
    }
};

class npc_heated_battle : public CreatureScript
{
public:
    npc_heated_battle() : CreatureScript("npc_heated_battle") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return new npc_heated_battleAI (pCreature);
    }

    struct npc_heated_battleAI : public CombatAI
    {
        npc_heated_battleAI(Creature* c) : CombatAI(c) {}

        void Reset() override
        {
            me->SetCorpseDelay(60);
            CombatAI::Reset();
            if (Unit* target = me->SelectNearestTarget(50.0f))
                AttackStart(target);
        }

        void DamageTaken(Unit* who, uint32&, DamageEffectType, SpellSchoolMask) override
        {
            if (who && who->IsPlayer())
            {
                me->SetLootRecipient(who);
                me->LowerPlayerDamageReq(me->GetMaxHealth());
            }
        }
    };
};

enum eFrostmourneCavern
{
    NPC_PRINCE_ARTHAS               = 27455,
};

class spell_q12478_frostmourne_cavern : public SpellScript
{
    PrepareSpellScript(spell_q12478_frostmourne_cavern);

    void HandleSendEvent(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        GetCaster()->SummonCreature(NPC_PRINCE_ARTHAS, 4821.3f, -580.14f, 163.541f, 4.57f);
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_q12478_frostmourne_cavern::HandleSendEvent, EFFECT_0, SPELL_EFFECT_SEND_EVENT);
    }
};

class spell_q12243_fire_upon_the_waters_aura : public AuraScript
{
    PrepareAuraScript(spell_q12243_fire_upon_the_waters_aura);

    void HandleApplyEffect(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        std::list<Creature*> servants;
        GetTarget()->GetCreatureListWithEntryInGrid(servants, 27233 /*NPC_ONSLAUGHT_DECKHAND*/, 40.0f);
        for (std::list<Creature*>::const_iterator itr = servants.begin(); itr != servants.end(); ++itr)
        {
            (*itr)->SetSpeed(MOVE_RUN, 0.7f, true);
            (*itr)->GetMotionMaster()->MoveFleeing(GetTarget(), GetDuration());
        }
    }

    void HandleRemoveEffect(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        std::list<Creature*> servants;
        GetTarget()->GetCreatureListWithEntryInGrid(servants, 27233 /*NPC_ONSLAUGHT_DECKHAND*/, 100.0f);
        for (std::list<Creature*>::const_iterator itr = servants.begin(); itr != servants.end(); ++itr)
            (*itr)->SetSpeed(MOVE_RUN, 1.1f, true);
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_q12243_fire_upon_the_waters_aura::HandleApplyEffect, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
        OnEffectRemove += AuraEffectRemoveFn(spell_q12243_fire_upon_the_waters_aura::HandleRemoveEffect, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
    }
};

// The Sacred and the Corrupt (24545)

enum eSandC
{
    QUEST_THE_SACRED_AND_THE_CORRUPT = 24545,
    NPC_SAC_LICH_KING = 37857,
    NPC_SAC_LIGHTS_VENGEANCE = 37826,
    NPC_SAC_LIGHTS_VENGEANCE_VEH_1 = 37827,
    NPC_SAC_LIGHTS_VENGEANCE_VEH_2 = 37952,
    NPC_SAC_LIGHTS_VENGEANCE_BUNNY = 38001,
    NPC_SAC_WRETCHED_GHOUL = 37881,
    NPC_SAC_VEGARD_1 = 37893,
    GO_SAC_LIGHTS_VENGEANCE_1 = 201844,
    GO_SAC_LIGHTS_VENGEANCE_2 = 201922,
    GO_SAC_LIGHTS_VENGEANCE_3 = 201937,
    SPELL_SAC_STUN = 70583,
    SPELL_SAC_REPEL_HAMMER = 70590,
    SPELL_SAC_HOLY_ZONE_AURA = 70571,
    SPELL_SAC_THROW_HAMMER = 70595,
    SPELL_SAC_SUMMON_GO_1 = 70603,
    SPELL_SAC_SUMMON_GHOULS_AURA = 70612,
    SPELL_SAC_EMERGE = 50142,
    SPELL_SAC_SHIELD_OF_THE_LICH_KING = 70692,
    SPELL_SAC_ZAP_PLAYER = 70653,
    SPELL_SAC_LK_DESPAWN_ANIM = 70673,
    SPELL_SAC_VEGARD_SUMMON_GHOULS_AURA = 70737,
    SPELL_SAC_GHOUL_AREA_AURA = 70782,
    SPELL_SAC_HOLY_BOMB_VISUAL = 70785,
    SPELL_SAC_HOLY_BOMB_EXPLOSION = 70786,
    SPELL_SAC_ZAP_GHOULS_AURA = 70789,
    SPELL_SAC_GHOUL_EXPLODE = 70787,
    SPELL_SAC_KILL_VEGARD = 70792,
    SPELL_SAC_SUMMON_GO_2 = 70894,
    SPELL_SAC_SUMMON_VEGARD_SKELETON = 70862,
    SPELL_SAC_HAMMER_SHIELD = 70970,
    SPELL_SAC_SUMMON_GO_3 = 70967,

    // Xinef:
    SPELL_SAC_BLUE_EXPLOSION = 70509,
    SPELL_SAC_VEHICLE_CONTROL_AURA = 70510,
};

class WretchedGhoulCleaner
{
public:
    void operator()(Creature* creature)
    {
        if (creature->GetEntry() == NPC_SAC_WRETCHED_GHOUL && creature->GetDisplayId() != 11686 && creature->IsAlive())
            Unit::Kill(creature, creature);
    }
};

class npc_q24545_lich_king : public CreatureScript
{
public:
    npc_q24545_lich_king() : CreatureScript("npc_q24545_lich_king") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return new npc_q24545_lich_kingAI (pCreature);
    }

    struct npc_q24545_lich_kingAI : public NullCreatureAI
    {
        npc_q24545_lich_kingAI(Creature* c) : NullCreatureAI(c), summons(me)
        {
        }

        EventMap events;
        SummonList summons;
        ObjectGuid playerGUID;

        void CleanAll(bool fromReset = true)
        {
            if (Creature* c = me->FindNearestCreature(NPC_SAC_LIGHTS_VENGEANCE_BUNNY, 150.0f, true))
                c->RemoveAllAuras();
            if (fromReset)
            {
                if (Creature* c = me->FindNearestCreature(NPC_SAC_LIGHTS_VENGEANCE, 150.0f, true))
                    c->DespawnOrUnsummon(1);
                if (Creature* c = me->FindNearestCreature(NPC_SAC_LIGHTS_VENGEANCE_VEH_1, 150.0f, true))
                    c->RemoveAllAuras();
            }
            if (Creature* c = me->FindNearestCreature(NPC_SAC_LIGHTS_VENGEANCE_VEH_2, 150.0f, true))
                c->DespawnOrUnsummon(1);
            if (GameObject* go = me->FindNearestGameObject(GO_SAC_LIGHTS_VENGEANCE_1, 150.0f))
                go->Delete();
            if (GameObject* go = me->FindNearestGameObject(GO_SAC_LIGHTS_VENGEANCE_2, 150.0f))
                go->Delete();
            WretchedGhoulCleaner cleaner;
            Acore::CreatureWorker<WretchedGhoulCleaner> worker(me, cleaner);
            Cell::VisitGridObjects(me, worker, 150.0f);
        }

        void Reset() override
        {
            events.Reset();
            events.ScheduleEvent(998, 10s);
            events.ScheduleEvent(999, 0ms);
            events.ScheduleEvent(1, 3s);
            summons.DespawnAll();
            playerGUID.Clear();

            CleanAll();

            me->setActive(false);
            me->SetWalk(true);
            me->SetVisible(false);
            me->RemoveAllAuras();
            me->InterruptNonMeleeSpells(true);
            float x, y, z, o;
            me->GetHomePosition(x, y, z, o);
            me->UpdatePosition(x, y, z, o, true);
            me->StopMovingOnCurrentPos();
            me->GetMotionMaster()->Clear();
        }

        void SetGUID(ObjectGuid guid, int32  /*id*/) override
        {
            if (playerGUID || events.GetNextEventTime(998) || events.GetNextEventTime(2))
                return;

            me->setActive(true);
            playerGUID = guid;
            events.ScheduleEvent(2, 15min);
            events.ScheduleEvent(3, 0ms);
        }

        void SetData(uint32 type, uint32 data) override
        {
            if (!playerGUID || type != data)
                return;
            if (data == 1)
                events.ScheduleEvent(15, 0ms);
            else if (data == 2)
            {
                if (GameObject* go = me->FindNearestGameObject(GO_SAC_LIGHTS_VENGEANCE_2, 150.0f))
                    go->Delete();
                if (Creature* c = me->FindNearestCreature(NPC_SAC_LIGHTS_VENGEANCE_VEH_1, 150.0f, true))
                {
                    c->CastSpell(c, SPELL_SAC_HAMMER_SHIELD, true);
                    c->CastSpell(c, SPELL_SAC_SUMMON_GO_3, true);
                    if (Player* p = ObjectAccessor::GetPlayer(*me, playerGUID))
                        p->KnockbackFrom(c->GetPositionX(), c->GetPositionY(), 5.0f, 3.0f);
                }
                events.ScheduleEvent(18, 3s);
            }
            else if (data == 3)
            {
                if (Creature* c = me->FindNearestCreature(NPC_SAC_LIGHTS_VENGEANCE_VEH_1, 150.0f, true))
                {
                    c->RemoveAllAuras();
                    c->CastSpell(c, SPELL_SAC_HOLY_ZONE_AURA, true);
                    if (GameObject* go = me->FindNearestGameObject(GO_SAC_LIGHTS_VENGEANCE_3, 150.0f))
                        go->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                    playerGUID.Clear();
                    events.RescheduleEvent(2, 1min);
                }
            }
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);
            switch (events.ExecuteEvent())
            {
                case 0:
                    break;
                case 998: // ensure everything is cleaned up
                    CleanAll(false);
                    break;
                case 999: // apply holy aura
                    if (Creature* c = me->FindNearestCreature(NPC_SAC_LIGHTS_VENGEANCE_VEH_1, 150.0f, true))
                        if (Creature* l = me->SummonCreature(NPC_SAC_LIGHTS_VENGEANCE, *c, TEMPSUMMON_MANUAL_DESPAWN))
                        {
                            l->CastSpell(c, SPELL_SAC_VEHICLE_CONTROL_AURA, true);
                            c->CastSpell(c, SPELL_SAC_HOLY_ZONE_AURA, true);
                        }
                    break;
                case 1: // check player
                    if (playerGUID)
                    {
                        bool valid = false;
                        if (Player* p = ObjectAccessor::GetPlayer(*me, playerGUID))
                            if (p->IsAlive() && p->GetPhaseMask() & 2 && p->GetExactDistSq(me) < 100.0f * 100.0f && !p->IsGameMaster())
                                valid = true;
                        if (!valid)
                        {
                            Reset();
                            return;
                        }
                    }
                    events.ScheduleEvent(1, 3s);
                    break;
                case 2: // reset timer
                    Reset();
                    break;
                case 3: // start event
                    if (Player* p = ObjectAccessor::GetPlayer(*me, playerGUID))
                    {
                        me->CastSpell(p, SPELL_SAC_STUN, true);
                        me->SetVisible(true);
                        Movement::PointsArray path;
                        path.push_back(G3D::Vector3(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()));
                        path.push_back(G3D::Vector3(4825.35f, -582.99f, 164.83f));
                        path.push_back(G3D::Vector3(4813.38f, -580.94f, 162.62f));
                        me->GetMotionMaster()->MoveSplinePath(&path);
                        events.ScheduleEvent(4, 10s);
                    }
                    break;
                case 4: // talk 0
                    Talk(0);
                    events.ScheduleEvent(5, 6s);
                    break;
                case 5: // talk 1
                    Talk(1);
                    events.ScheduleEvent(6, 4s);
                    events.ScheduleEvent(7, 11s);
                    break;
                case 6: // repel hammer
                    me->CastSpell((Unit*)nullptr, SPELL_SAC_REPEL_HAMMER, false);
                    if (Creature* c = me->FindNearestCreature(NPC_SAC_LIGHTS_VENGEANCE_VEH_1, 150.0f, true))
                        c->CastSpell(c, SPELL_SAC_BLUE_EXPLOSION, true);

                    events.ScheduleEvent(65, 3500ms);
                    break;
                case 65: // spawn hammer go
                    if (Creature* c = me->FindNearestCreature(NPC_SAC_LIGHTS_VENGEANCE_BUNNY, 150.0f, true))
                    {
                        c->CastSpell(c, SPELL_SAC_HOLY_ZONE_AURA, true);
                        c->CastSpell(c, SPELL_SAC_SUMMON_GO_1, true);
                    }
                    break;
                case 7: // talk 2
                    Talk(2);
                    events.ScheduleEvent(8, 8s);
                    events.ScheduleEvent(9, 11s + 500ms);
                    break;
                case 8: // summon ghouls
                    me->CastSpell((Unit*)nullptr, SPELL_SAC_SUMMON_GHOULS_AURA, false);
                    break;
                case 9: // talk 3
                    Talk(3);
                    events.ScheduleEvent(10, 10s);
                    break;
                case 10: // summon vegard
                    me->SummonCreature(NPC_SAC_VEGARD_1, 4812.12f, -586.08f, 162.49f, 3.14f, TEMPSUMMON_MANUAL_DESPAWN);
                    events.ScheduleEvent(11, 4s);
                    events.ScheduleEvent(12, 5s);
                    break;
                case 11: // vagard shield
                    if (Creature* c = me->FindNearestCreature(NPC_SAC_VEGARD_1, 50.0f, true))
                        c->CastSpell(c, SPELL_SAC_SHIELD_OF_THE_LICH_KING, false);
                    break;
                case 12: // talk 4
                    Talk(4);
                    if (Player* p = ObjectAccessor::GetPlayer(*me, playerGUID))
                        me->CastSpell(p, SPELL_SAC_ZAP_PLAYER, false);
                    events.ScheduleEvent(13, 3500ms);
                    events.ScheduleEvent(14, 6s);
                    break;
                case 13: // despawn
                    me->CastSpell(me, SPELL_SAC_LK_DESPAWN_ANIM, false);
                    break;
                case 14: // vagard talk 0
                    me->SetVisible(false);
                    me->RemoveAllAuras();
                    if (Creature* c = me->FindNearestCreature(NPC_SAC_VEGARD_1, 50.0f, true))
                    {
                        c->AI()->Talk(0);
                        c->CastSpell(c, SPELL_SAC_VEGARD_SUMMON_GHOULS_AURA, false);
                    }
                    if (GameObject* go = me->FindNearestGameObject(GO_SAC_LIGHTS_VENGEANCE_1, 150.0f))
                        go->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                    break;
                case 15: // remove light
                    if (Creature* x = me->FindNearestCreature(NPC_SAC_LIGHTS_VENGEANCE_VEH_2, 150.0f, true))
                        if (Creature* c = me->FindNearestCreature(NPC_SAC_LIGHTS_VENGEANCE_BUNNY, 150.0f, true))
                        {
                            c->RemoveAurasDueToSpell(SPELL_SAC_HOLY_ZONE_AURA);
                            if (Creature* l = me->SummonCreature(NPC_SAC_LIGHTS_VENGEANCE, *c, TEMPSUMMON_MANUAL_DESPAWN))
                            {
                                x->SetCanFly(true);
                                x->SetDisableGravity(true);
                                x->SetHover(true);
                                x->NearTeleportTo(4812.09f, -585.55f, 172.03f, 3.75f);
                                l->EnterVehicle(x, 1);
                                //l->ClearUnitState(UNIT_STATE_ONVEHICLE);
                                l->CastSpell(l, SPELL_SAC_HOLY_BOMB_VISUAL, false);
                                l->AddAura(SPELL_SAC_HOLY_BOMB_VISUAL, l);
                                events.ScheduleEvent(16, 5s);
                            }
                        }
                    break;
                case 16: // add aura to kill ghouls
                    if (Creature* c = me->FindNearestCreature(NPC_SAC_LIGHTS_VENGEANCE, 150.0f, true))
                        c->CastSpell(c, SPELL_SAC_ZAP_GHOULS_AURA, true);
                    if (Creature* c = me->FindNearestCreature(NPC_SAC_VEGARD_1, 50.0f, true))
                        c->RemoveAurasDueToSpell(SPELL_SAC_VEGARD_SUMMON_GHOULS_AURA);
                    events.ScheduleEvent(17, 12s);
                    break;
                case 17: // kill vegard
                    {
                        WretchedGhoulCleaner cleaner;
                        Acore::CreatureWorker<WretchedGhoulCleaner> worker(me, cleaner);
                        Cell::VisitGridObjects(me, worker, 150.0f);

                        if (Creature* c = me->FindNearestCreature(NPC_SAC_LIGHTS_VENGEANCE, 150.0f, true))
                            if (Creature* v = me->FindNearestCreature(NPC_SAC_VEGARD_1, 50.0f, true))
                                if (Creature* b = me->FindNearestCreature(NPC_SAC_LIGHTS_VENGEANCE_VEH_1, 150.0f, true))
                                {
                                    c->CastSpell(v, SPELL_SAC_KILL_VEGARD, true);
                                    v->SetDisplayId(11686);
                                    v->DespawnOrUnsummon(1000);
                                    b->CastSpell(b, SPELL_SAC_HOLY_BOMB_EXPLOSION, true);
                                    b->CastSpell(b, SPELL_SAC_SUMMON_GO_2, true);
                                    if (Unit* vb = c->GetVehicleBase())
                                    {
                                        if (Unit* pass = vb->GetVehicleKit()->GetPassenger(0))
                                            if (pass->IsCreature())
                                                pass->ToCreature()->DespawnOrUnsummon(1);
                                        vb->RemoveAllAuras();
                                        vb->ToCreature()->DespawnOrUnsummon(1);
                                    }
                                    c->ToCreature()->DespawnOrUnsummon(1);
                                }
                    }
                    break;
                case 18: // summon vegard
                    me->CastSpell(me, SPELL_SAC_SUMMON_VEGARD_SKELETON, true);
                    break;
            }
        }

        void JustSummoned(Creature* summon) override
        {
            summons.Summon(summon);
        }

        void SummonedCreatureDespawn(Creature* summon) override
        {
            summons.Despawn(summon);
        }

        void SpellHitTarget(Unit* target, SpellInfo const* spell) override
        {
            if (spell->Id == SPELL_SAC_REPEL_HAMMER && target->IsCreature())
            {
                target->CastSpell((Unit*)nullptr, SPELL_SAC_THROW_HAMMER, true);
                target->ToCreature()->DespawnOrUnsummon(1);
                if (Unit* c = target->GetVehicleBase())
                    c->RemoveAurasDueToSpell(SPELL_SAC_HOLY_ZONE_AURA);
            }
        }
    };
};

class at_q24545_frostmourne_cavern : public AreaTriggerScript
{
public:
    at_q24545_frostmourne_cavern() : AreaTriggerScript("at_q24545_frostmourne_cavern") { }

    bool OnTrigger(Player* player, AreaTrigger const* /*areaTrigger*/) override
    {
        if (player->GetPhaseMask() & 2)
            if (Creature* c = player->FindNearestCreature(NPC_SAC_LICH_KING, 60.0f, true))
                c->AI()->SetGUID(player->GetGUID());

        return true;
    }
};

class SACActivateEvent : public BasicEvent
{
public:
    SACActivateEvent(Creature* owner) : _owner(owner) {}

    bool Execute(uint64 /*time*/, uint32 /*diff*/) override
    {
        if (!_owner->IsAlive())
            return true;
        _owner->GetMotionMaster()->MoveRandom(5.0f);
        _owner->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
        _owner->SetReactState(REACT_AGGRESSIVE);
        _owner->CastSpell(_owner, SPELL_SAC_GHOUL_AREA_AURA, true);
        return true;
    }

private:
    Creature* _owner;
};

class SACDeactivateEvent : public BasicEvent
{
public:
    SACDeactivateEvent(Creature* owner) : _owner(owner) {}

    bool Execute(uint64 /*time*/, uint32 /*diff*/) override
    {
        _owner->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
        _owner->SetReactState(REACT_PASSIVE);
        _owner->SetDisplayId(11686);
        return true;
    }

private:
    Creature* _owner;
};

class npc_q24545_wretched_ghoul : public CreatureScript
{
public:
    npc_q24545_wretched_ghoul() : CreatureScript("npc_q24545_wretched_ghoul") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return new npc_q24545_wretched_ghoulAI (pCreature);
    }

    struct npc_q24545_wretched_ghoulAI : public ScriptedAI
    {
        npc_q24545_wretched_ghoulAI(Creature* c) : ScriptedAI(c)
        {
            Deactivate();
        }

        void Reset() override
        {
            me->SetCorpseDelay(3);
        }

        void DoAction(int32 a) override
        {
            if (a == -1)
                Activate();
            else if (a == -2)
            {
                me->CastSpell(me, SPELL_SAC_GHOUL_EXPLODE, true);
                me->KillSelf();
                me->m_Events.KillAllEvents(true);
                Deactivate();
            }
        }

        void AttackStart(Unit* who) override
        {
            if (me->HasUnitFlag(UNIT_FLAG_NOT_SELECTABLE))
                return;
            ScriptedAI::AttackStart(who);
        }

        bool CanAIAttack(Unit const* target) const override
        {
            if (me->HasUnitFlag(UNIT_FLAG_NOT_SELECTABLE) || target->HasUnitState(UNIT_STATE_STUNNED) || me->GetDisplayId() == 11686)
                return false;
            Position homePos = me->GetHomePosition();
            return target->GetExactDistSq(&homePos) < 30.0f * 30.0f;
        }

        void Activate()
        {
            me->SetDisplayId(me->GetNativeDisplayId());
            me->CastSpell(me, SPELL_SAC_EMERGE, true);
            me->m_Events.AddEvent(new SACActivateEvent(me), me->m_Events.CalculateTime(4000));
        }

        void Deactivate()
        {
            me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
            me->SetReactState(REACT_PASSIVE);
            me->SetDisplayId(11686);
        }

        void JustDied(Unit* /*killer*/) override
        {
            me->RemoveAurasDueToSpell(SPELL_SAC_GHOUL_AREA_AURA);
            me->m_Events.AddEvent(new SACDeactivateEvent(me), me->m_Events.CalculateTime(4000));
        }

        void JustRespawned() override
        {
            Deactivate();
        }
    };
};

class GhoulTargetCheck
{
public:
    explicit GhoulTargetCheck(bool alive) : _alive(alive) {}
    bool operator()(WorldObject* object) const
    {
        return _alive ^ (!object->IsCreature() || ((Unit*)object)->GetDisplayId() != 11686);
    }
private:
    bool _alive;
};

class spell_q24545_aod_special : public SpellScript
{
    PrepareSpellScript(spell_q24545_aod_special);

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        targets.remove_if(GhoulTargetCheck(GetSpellInfo()->Id == 70790));
        Acore::Containers::RandomResize(targets, 2);
    }

    void HandleScript(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (Unit* target = GetHitUnit())
            if (target->IsCreature())
                target->ToCreature()->AI()->DoAction(GetSpellInfo()->Id == 70790 ? -2 : -1);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_q24545_aod_special::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENTRY);
        OnEffectHitTarget += SpellEffectFn(spell_q24545_aod_special::HandleScript, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

class npc_q24545_vegard_dummy : public CreatureScript
{
public:
    npc_q24545_vegard_dummy() : CreatureScript("npc_q24545_vegard_dummy") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return new npc_q24545_vegard_dummyAI (pCreature);
    }

    struct npc_q24545_vegard_dummyAI : public NullCreatureAI
    {
        npc_q24545_vegard_dummyAI(Creature* c) : NullCreatureAI(c)
        {
            done = false;
        }

        bool done;

        void UpdateAI(uint32  /*diff*/) override
        {
            if (!done)
            {
                done = true;
                me->CastSpell(me, SPELL_SAC_EMERGE, true);
            }
        }
    };
};

class npc_q24545_vegard : public CreatureScript
{
public:
    npc_q24545_vegard() : CreatureScript("npc_q24545_vegard") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return new npc_q24545_vegardAI (pCreature);
    }

    struct npc_q24545_vegardAI : public ScriptedAI
    {
        npc_q24545_vegardAI(Creature* c) : ScriptedAI(c)
        {
            me->SetReactState(REACT_PASSIVE);
            me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            events.Reset();
            events.ScheduleEvent(1, 7s);
            events.ScheduleEvent(2, 7s, 20s);
            events.ScheduleEvent(3, 7s, 20s);
            events.ScheduleEvent(4, 7s, 20s);
            events.ScheduleEvent(5, 7s, 20s);
            events.ScheduleEvent(6, 1ms);
        }

        EventMap events;

        void JustDied(Unit* /*killer*/) override
        {
            Talk(1);
            me->DespawnOrUnsummon(10000);
            if (Creature* c = me->FindNearestCreature(NPC_SAC_LICH_KING, 200.0f, true))
                c->AI()->SetData(3, 3);
        }

        void KilledUnit(Unit* who) override
        {
            if (who->IsPlayer())
                Talk(2);
        }

        void UpdateAI(uint32 diff) override
        {
            UpdateVictim();
            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;
            switch (events.ExecuteEvent())
            {
                case 0:
                    break;
                case 1:
                    me->SetReactState(REACT_AGGRESSIVE);
                    me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                    if (Unit* t = me->SelectNearestTarget(50.0f))
                        AttackStart(t);
                    break;
                case 2:
                    me->CastSpell((Unit*)nullptr, 70866, false);
                    events.Repeat(30s, 35s);
                    break;
                case 3:
                    if (me->GetVictim())
                        me->CastSpell(me->GetVictim(), 70886, false);
                    events.Repeat(15s, 30s);
                    break;
                case 4:
                    if (me->GetVictim())
                        me->CastSpell(me->GetVictim(), 71003, false);
                    events.Repeat(15s, 30s);
                    break;
                case 5:
                    if (me->GetVictim())
                        me->CastSpell(me->GetVictim(), 70864, false);
                    events.Repeat(8s, 12s);
                    break;
                case 6:
                    Talk(0);
                    me->CastSpell(me, SPELL_SAC_EMERGE, true);
                    break;
            }
            DoMeleeAttackIfReady();
        }
    };
};

class npc_spiritual_insight : public CreatureScript
{
public:
    npc_spiritual_insight() : CreatureScript("npc_spiritual_insight") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return new npc_spiritual_insightAI (pCreature);
    }

    struct npc_spiritual_insightAI : public NullCreatureAI
    {
        npc_spiritual_insightAI(Creature* c) : NullCreatureAI(c) {}

        uint8 GetSpeachId()
        {
            if (me->GetDistance2d(2686, 934) < 2.0f)
                return 0;
            if (me->GetDistance2d(3097, 1037) < 2.0f)
                return 1;
            if (me->GetDistance2d(3014, 1321) < 2.0f)
                return 2;
            if (me->GetDistance2d(2854, 1514) < 2.0f)
                return 3;
            if (me->GetDistance2d(3129, 1556) < 2.0f)
                return 4;

            return 5;
        }

        void IsSummonedBy(WorldObject* summoner) override
        {
            if (!summoner || !summoner->IsPlayer())
                return;

            uint8 id = GetSpeachId();
            std::string const& text = sCreatureTextMgr->GetLocalizedChatString(me->GetEntry(), 0, id, 0, LOCALE_enUS);
            WorldPacket data;
            ChatHandler::BuildChatPacket(data, CHAT_MSG_MONSTER_WHISPER, LANG_UNIVERSAL, me->GetGUID(), summoner->GetGUID(), text, CHAT_TAG_NONE, "Toalu'u the Mystic");
            summoner->ToPlayer()->SendDirectMessage(&data);

            if (id == 1)
                if (Aura* aura = summoner->ToUnit()->GetAura(47189)) // Transform Aura
                    aura->SetDuration(aura->GetDuration() - MINUTE * IN_MILLISECONDS);
        }
    };
};

// Theirs

/*#####
# npc_commander_eligor_dawnbringer
#####*/

enum CommanderEligorDawnbringer
{
    MODEL_IMAGE_OF_KELTHUZAD           = 24787, // Image of Kel'Thuzad
    MODEL_IMAGE_OF_SAPPHIRON           = 24788, // Image of Sapphiron
    MODEL_IMAGE_OF_RAZUVIOUS           = 24799, // Image of Razuvious
    MODEL_IMAGE_OF_GOTHIK              = 24804, // Image of Gothik
    MODEL_IMAGE_OF_THANE               = 24802, // Image of Thane Korth'azz
    MODEL_IMAGE_OF_BLAUMEUX            = 24794, // Image of Lady Blaumeux
    MODEL_IMAGE_OF_ZELIEK              = 24800, // Image of Sir Zeliek
    MODEL_IMAGE_OF_PATCHWERK           = 24798, // Image of Patchwerk
    MODEL_IMAGE_OF_GROBBULUS           = 24792, // Image of Grobbulus
    MODEL_IMAGE_OF_THADDIUS            = 24801, // Image of Thaddius
    MODEL_IMAGE_OF_GLUTH               = 24803, // Image of Gluth
    MODEL_IMAGE_OF_ANUBREKHAN          = 24789, // Image of Anub'rekhan
    MODEL_IMAGE_OF_FAERLINA            = 24790, // Image of Faerlina
    MODEL_IMAGE_OF_MAEXXNA             = 24796, // Image of Maexxna
    MODEL_IMAGE_OF_NOTH                = 24797, // Image of Noth
    MODEL_IMAGE_OF_HEIGAN              = 24793, // Image of Heigan
    MODEL_IMAGE_OF_LOATHEB             = 24795, // Image of Loatheb

    NPC_IMAGE_OF_KELTHUZAD             = 27766, // Image of Kel'Thuzad
    NPC_IMAGE_OF_SAPPHIRON             = 27767, // Image of Sapphiron
    NPC_IMAGE_OF_RAZUVIOUS             = 27768, // Image of Razuvious
    NPC_IMAGE_OF_GOTHIK                = 27769, // Image of Gothik
    NPC_IMAGE_OF_THANE                 = 27770, // Image of Thane Korth'azz
    NPC_IMAGE_OF_BLAUMEUX              = 27771, // Image of Lady Blaumeux
    NPC_IMAGE_OF_ZELIEK                = 27772, // Image of Sir Zeliek
    NPC_IMAGE_OF_PATCHWERK             = 27773, // Image of Patchwerk
    NPC_IMAGE_OF_GROBBULUS             = 27774, // Image of Grobbulus
    NPC_IMAGE_OF_THADDIUS              = 27775, // Image of Thaddius
    NPC_IMAGE_OF_GLUTH                 = 27782, // Image of Gluth
    NPC_IMAGE_OF_ANUBREKHAN            = 27776, // Image of Anub'rekhan
    NPC_IMAGE_OF_FAERLINA              = 27777, // Image of Faerlina
    NPC_IMAGE_OF_MAEXXNA               = 27778, // Image of Maexxna
    NPC_IMAGE_OF_NOTH                  = 27779, // Image of Noth
    NPC_IMAGE_OF_HEIGAN                = 27780, // Image of Heigan
    NPC_IMAGE_OF_LOATHEB               = 27781, // Image of Loatheb

    NPC_INFANTRYMAN                    = 27160, // Add in case I randomize the spawning
    NPC_SENTINAL                       = 27162,
    NPC_BATTLE_MAGE                    = 27164,

    // Five platforms to choose from
    SAY_PINNACLE                       = 0,
    SAY_DEATH_KNIGHT_WING              = 1,
    SAY_ABOMINATION_WING               = 2,
    SAY_SPIDER_WING                    = 3,
    SAY_PLAGUE_WING                    = 4,
    // Used in all talks
    SAY_TALK_COMPLETE                  = 5,
    // Pinnacle of Naxxramas
    SAY_SAPPHIRON                      = 6,
    SAY_KELTHUZAD_1                    = 7,
    SAY_KELTHUZAD_2                    = 8,
    SAY_KELTHUZAD_3                    = 9,
    // Death knight wing of Naxxramas
    SAY_RAZUVIOUS                      = 10,
    SAY_GOTHIK                         = 11,
    SAY_DEATH_KNIGHTS_1                = 12,
    SAY_DEATH_KNIGHTS_2                = 13,
    SAY_DEATH_KNIGHTS_3                = 14,
    SAY_DEATH_KNIGHTS_4                = 15,
    // Blighted abomination wing of Naxxramas
    SAY_PATCHWERK                      = 16,
    SAY_GROBBULUS                      = 17,
    SAY_GLUTH                          = 18,
    SAY_THADDIUS                       = 19,
    // Accursed spider wing of Naxxramas
    SAY_ANUBREKHAN                     = 20,
    SAY_FAERLINA                       = 21,
    SAY_MAEXXNA                        = 22,
    // Dread plague wing of Naxxramas
    SAY_NOTH                           = 23,
    SAY_HEIGAN_1                       = 24,
    SAY_HEIGAN_2                       = 25,
    SAY_LOATHEB                        = 26,

    SPELL_HEROIC_IMAGE_CHANNEL         = 49519,

    EVENT_START_RANDOM                 = 1,
    EVENT_MOVE_TO_POINT                = 2,
    EVENT_TALK_COMPLETE                = 3,
    EVENT_GET_TARGETS                  = 4,
    EVENT_KELTHUZAD_2                  = 5,
    EVENT_KELTHUZAD_3                  = 6,
    EVENT_DEATH_KNIGHTS_2              = 7,
    EVENT_DEATH_KNIGHTS_3              = 8,
    EVENT_DEATH_KNIGHTS_4              = 9,
    EVENT_HEIGAN_2                     = 10
};

uint32 const AudienceMobs[3] = { NPC_INFANTRYMAN, NPC_SENTINAL, NPC_BATTLE_MAGE };

Position const PosTalkLocations[6] =
{
    { 3805.453f, -682.9075f, 222.2917f, 2.793398f }, // Pinnacle of Naxxramas
    { 3807.508f, -691.0882f, 221.9688f, 2.094395f }, // Death knight wing of Naxxramas
    { 3797.228f, -690.3555f, 222.5019f, 1.134464f }, // Blighted abomination wing of Naxxramas
    { 3804.038f, -672.3098f, 222.5019f, 4.578917f }, // Accursed spider wing of Naxxramas
    { 3815.097f, -680.2596f, 221.9777f, 2.86234f  }, // Dread plague wing of Naxxramas
    { 3798.05f,  -680.611f,  222.9825f, 6.038839f }, // Home
};

class npc_commander_eligor_dawnbringer : public CreatureScript
{
public:
    npc_commander_eligor_dawnbringer() : CreatureScript("npc_commander_eligor_dawnbringer") {}

    struct npc_commander_eligor_dawnbringerAI : public ScriptedAI
    {
        npc_commander_eligor_dawnbringerAI(Creature* creature) : ScriptedAI(creature)
        {
            talkWing = 0;
        }

        void Reset() override
        {
            talkWing = 0;

            for (uint8 i = 0; i < 10; ++i)
                audienceList[i].Clear();

            for (uint8 i = 0; i < 5; ++i)
                imageList[i].Clear();

            _events.ScheduleEvent(EVENT_GET_TARGETS, 5s);
            _events.ScheduleEvent(EVENT_START_RANDOM, 20s);
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type == POINT_MOTION_TYPE)
            {
                if (id == 1)
                {
                    me->SetFacingTo(PosTalkLocations[talkWing].GetOrientation());
                    TurnAudience();

                    switch (talkWing)
                    {
                        case 0: // Pinnacle of Naxxramas
                            {
                                switch (urand (0, 1))
                                {
                                    case 0:
                                        ChangeImage(NPC_IMAGE_OF_KELTHUZAD, MODEL_IMAGE_OF_KELTHUZAD, SAY_KELTHUZAD_1);
                                        _events.ScheduleEvent(EVENT_KELTHUZAD_2, 8s);
                                        break;
                                    case 1:
                                        ChangeImage(NPC_IMAGE_OF_SAPPHIRON, MODEL_IMAGE_OF_SAPPHIRON, SAY_SAPPHIRON);
                                        break;
                                }
                            }
                            break;
                        case 1: // Death knight wing of Naxxramas
                            {
                                switch (urand (0, 2))
                                {
                                    case 0:
                                        ChangeImage(NPC_IMAGE_OF_RAZUVIOUS, MODEL_IMAGE_OF_RAZUVIOUS, SAY_RAZUVIOUS);
                                        break;
                                    case 1:
                                        ChangeImage(NPC_IMAGE_OF_GOTHIK, MODEL_IMAGE_OF_GOTHIK, SAY_GOTHIK);
                                        break;
                                    case 2:
                                        ChangeImage(NPC_IMAGE_OF_THANE, MODEL_IMAGE_OF_THANE, SAY_DEATH_KNIGHTS_1);
                                        _events.ScheduleEvent(EVENT_DEATH_KNIGHTS_2, 10s);
                                        break;
                                }
                            }
                            break;
                        case 2: // Blighted abomination wing of Naxxramas
                            {
                                switch (urand (0, 3))
                                {
                                    case 0:
                                        ChangeImage(NPC_IMAGE_OF_PATCHWERK, MODEL_IMAGE_OF_PATCHWERK, SAY_PATCHWERK);
                                        break;
                                    case 1:
                                        ChangeImage(NPC_IMAGE_OF_GROBBULUS, MODEL_IMAGE_OF_GROBBULUS, SAY_GROBBULUS);
                                        break;
                                    case 2:
                                        ChangeImage(NPC_IMAGE_OF_THADDIUS, MODEL_IMAGE_OF_THADDIUS, SAY_THADDIUS);
                                        break;
                                    case 3:
                                        ChangeImage(NPC_IMAGE_OF_GLUTH, MODEL_IMAGE_OF_GLUTH, SAY_GLUTH);
                                        break;
                                }
                            }
                            break;
                        case 3: // Accursed spider wing of Naxxramas
                            {
                                switch (urand (0, 2))
                                {
                                    case 0:
                                        ChangeImage(NPC_IMAGE_OF_ANUBREKHAN, MODEL_IMAGE_OF_ANUBREKHAN, SAY_ANUBREKHAN);
                                        break;
                                    case 1:
                                        ChangeImage(NPC_IMAGE_OF_FAERLINA, MODEL_IMAGE_OF_FAERLINA, SAY_FAERLINA);
                                        break;
                                    case 2:
                                        ChangeImage(NPC_IMAGE_OF_MAEXXNA, MODEL_IMAGE_OF_MAEXXNA, SAY_MAEXXNA);
                                        break;
                                }
                            }
                            break;
                        case 4: // Dread plague wing of Naxxramas
                            {
                                switch (urand (0, 2))
                                {
                                    case 0:
                                        ChangeImage(NPC_IMAGE_OF_NOTH, MODEL_IMAGE_OF_NOTH, SAY_NOTH);
                                        break;
                                    case 1:
                                        ChangeImage(NPC_IMAGE_OF_HEIGAN, MODEL_IMAGE_OF_HEIGAN, SAY_HEIGAN_1);
                                        _events.ScheduleEvent(EVENT_HEIGAN_2, 8s);
                                        break;
                                    case 2:
                                        ChangeImage(NPC_IMAGE_OF_LOATHEB, MODEL_IMAGE_OF_LOATHEB, SAY_LOATHEB);
                                        break;
                                }
                            }
                            break;
                        case 5: // Home
                            _events.ScheduleEvent(EVENT_START_RANDOM, 30s);
                            break;
                    }
                }
            }
        }

        void StoreTargets()
        {
            uint8 creturesCount = 0;

            for (uint8 ii = 0; ii < 3; ++ii)
            {
                std::list<Creature*> creatureList;
                GetCreatureListWithEntryInGrid(creatureList, me, AudienceMobs[ii], 15.0f);
                for (std::list<Creature*>::iterator itr = creatureList.begin(); itr != creatureList.end(); ++itr)
                {
                    if (Creature* creature = *itr)
                    {
                        audienceList[creturesCount] = creature->GetGUID();
                        ++creturesCount;
                    }
                }
            }

            if (Creature* creature = me->FindNearestCreature(NPC_IMAGE_OF_KELTHUZAD, 20.0f, true))
                imageList[0] = creature->GetGUID();
            if (Creature* creature = me->FindNearestCreature(NPC_IMAGE_OF_RAZUVIOUS, 20.0f, true))
                imageList[1] = creature->GetGUID();
            if (Creature* creature = me->FindNearestCreature(NPC_IMAGE_OF_PATCHWERK, 20.0f, true))
                imageList[2] = creature->GetGUID();
            if (Creature* creature = me->FindNearestCreature(NPC_IMAGE_OF_ANUBREKHAN, 20.0f, true))
                imageList[3] = creature->GetGUID();
            if (Creature* creature = me->FindNearestCreature(NPC_IMAGE_OF_NOTH, 20.0f, true))
                imageList[4] = creature->GetGUID();
        }

        void ChangeImage(uint32 entry, uint32 model, uint8 text)
        {
            if (Creature* creature = ObjectAccessor::GetCreature(*me, imageList[talkWing]))
            {
                Talk(text);
                creature->SetEntry(entry);
                creature->SetDisplayId(model);
                creature->CastSpell(creature, SPELL_HEROIC_IMAGE_CHANNEL);
                _events.ScheduleEvent(EVENT_TALK_COMPLETE, 40s);
            }
        }

        void TurnAudience()
        {
            for (uint8 i = 0; i < 10; ++i)
            {
                if (Creature* creature = ObjectAccessor::GetCreature(*me, audienceList[i]))
                    creature->SetFacingToObject(me);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            _events.Update(diff);

            while (uint32 eventId = _events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_START_RANDOM:
                        talkWing = urand (0, 4);
                        Talk(talkWing);
                        _events.ScheduleEvent(EVENT_MOVE_TO_POINT, 8s);
                        break;
                    case EVENT_MOVE_TO_POINT:
                        me->SetWalk(true);
                        me->GetMotionMaster()->Clear();
                        me->GetMotionMaster()->MovePoint(1, PosTalkLocations[talkWing].m_positionX, PosTalkLocations[talkWing].m_positionY, PosTalkLocations[talkWing].m_positionZ);
                        break;
                    case EVENT_TALK_COMPLETE:
                        talkWing = 5;
                        Talk(talkWing);
                        _events.ScheduleEvent(EVENT_MOVE_TO_POINT, 5s);
                        break;
                    case EVENT_GET_TARGETS:
                        StoreTargets();
                        break;
                    case EVENT_KELTHUZAD_2:
                        Talk(SAY_KELTHUZAD_2);
                        _events.ScheduleEvent(EVENT_KELTHUZAD_3, 8s);
                        break;
                    case EVENT_KELTHUZAD_3:
                        Talk(SAY_KELTHUZAD_3);
                        break;
                    case EVENT_DEATH_KNIGHTS_2:
                        Talk(SAY_DEATH_KNIGHTS_2);
                        if (Creature* creature = ObjectAccessor::GetCreature(*me, imageList[talkWing]))
                        {
                            creature->SetEntry(NPC_IMAGE_OF_BLAUMEUX);
                            creature->SetDisplayId(MODEL_IMAGE_OF_BLAUMEUX);
                        }
                        _events.ScheduleEvent(EVENT_DEATH_KNIGHTS_3, 10s);
                        break;
                    case EVENT_DEATH_KNIGHTS_3:
                        Talk(SAY_DEATH_KNIGHTS_3);
                        if (Creature* creature = ObjectAccessor::GetCreature(*me, imageList[talkWing]))
                        {
                            creature->SetEntry(NPC_IMAGE_OF_ZELIEK);
                            creature->SetDisplayId(MODEL_IMAGE_OF_ZELIEK);
                        }
                        _events.ScheduleEvent(EVENT_DEATH_KNIGHTS_4, 10s);
                        break;
                    case EVENT_DEATH_KNIGHTS_4:
                        Talk(SAY_DEATH_KNIGHTS_4);
                        break;
                    case EVENT_HEIGAN_2:
                        Talk(SAY_HEIGAN_2);
                        break;
                    default:
                        break;
                }
            }
            DoMeleeAttackIfReady();
        }
    private:
        EventMap _events;
        ObjectGuid audienceList[10];
        ObjectGuid imageList[5];
        uint8 talkWing;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_commander_eligor_dawnbringerAI(creature);
    }
};

/*######
## Quest Strengthen the Ancients (12096|12092)
######*/

enum StrengthenAncientsMisc
{
    SAY_WALKER_FRIENDLY         = 0,
    SAY_WALKER_ENEMY            = 1,
    SAY_LOTHALOR                = 0,

    SPELL_CREATE_ITEM_BARK      = 47550,
    SPELL_CONFUSED              = 47044,

    NPC_LOTHALOR                = 26321
};

class spell_q12096_q12092_dummy : public SpellScript
{
    PrepareSpellScript(spell_q12096_q12092_dummy);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_CREATE_ITEM_BARK });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        uint32 roll = rand() % 2;

        Creature* tree = GetHitCreature();
        Player* player = GetCaster()->ToPlayer();

        if (!tree || !player)
            return;

        tree->RemoveNpcFlag(UNIT_NPC_FLAG_SPELLCLICK);

        if (roll == 1) // friendly version
        {
            tree->CastSpell(player, SPELL_CREATE_ITEM_BARK);
            tree->AI()->Talk(SAY_WALKER_FRIENDLY, player);
            tree->DespawnOrUnsummon(1000);
        }
        else if (roll == 0) // enemy version
        {
            tree->AI()->Talk(SAY_WALKER_ENEMY, player);
            tree->SetFaction(FACTION_MONSTER);
            tree->Attack(player, true);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_q12096_q12092_dummy::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

class spell_q12096_q12092_bark : public SpellScript
{
    PrepareSpellScript(spell_q12096_q12092_bark);

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Creature* lothalor = GetHitCreature();
        if (!lothalor || lothalor->GetEntry() != NPC_LOTHALOR)
            return;

        lothalor->AI()->Talk(SAY_LOTHALOR);
        lothalor->RemoveAura(SPELL_CONFUSED);
        lothalor->DespawnOrUnsummon(4000);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_q12096_q12092_bark::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

/*#####
# npc_torturer_lecraft
#####*/

enum TorturerLeCraft
{
    SPELL_HEMORRHAGE                   = 30478,
    SPELL_KIDNEY_SHOT                  = 30621,
    SPELL_HIGH_EXECUTORS_BRANDING_IRON = 48603,
    NPC_TORTURER_LECRAFT               = 27394,
    EVENT_HEMORRHAGE                   = 1,
    EVENT_KIDNEY_SHOT                  = 2,
    SAY_AGGRO                          = 0
};

class npc_torturer_lecraft : public CreatureScript
{
public:
    npc_torturer_lecraft() : CreatureScript("npc_torturer_lecraft") {}

    struct npc_torturer_lecraftAI : public ScriptedAI
    {
        npc_torturer_lecraftAI(Creature* creature) : ScriptedAI(creature)
        {
            _playerGUID.Clear();
        }

        void Reset() override
        {
            _textCounter = 1;
            _playerGUID.Clear();
        }

        void JustEngagedWith(Unit* who) override
        {
            _events.ScheduleEvent(EVENT_HEMORRHAGE, urand(5000, 8000));
            _events.ScheduleEvent(EVENT_KIDNEY_SHOT, urand(12000, 15000));

            if (Player* player = who->ToPlayer())
                Talk (SAY_AGGRO, player);
        }

        void SpellHit(Unit* caster, SpellInfo const* spell) override
        {
            if (spell->Id != SPELL_HIGH_EXECUTORS_BRANDING_IRON)
                return;

            if (Player* player = caster->ToPlayer())
            {
                if (_textCounter == 1)
                    _playerGUID = player->GetGUID();

                if (_playerGUID != player->GetGUID())
                    return;

                Talk(_textCounter, player);

                if (_textCounter == 5)
                    player->KilledMonsterCredit(NPC_TORTURER_LECRAFT);

                ++_textCounter;

                if (_textCounter == 13)
                    _textCounter = 6;
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            _events.Update(diff);

            while (uint32 eventId = _events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_HEMORRHAGE:
                        DoCastVictim(SPELL_HEMORRHAGE);
                        _events.ScheduleEvent(EVENT_HEMORRHAGE, 12s, 168s);
                        break;
                    case EVENT_KIDNEY_SHOT:
                        DoCastVictim(SPELL_KIDNEY_SHOT);
                        _events.ScheduleEvent(EVENT_KIDNEY_SHOT, 20s, 26s);
                        break;
                    default:
                        break;
                }
            }
            DoMeleeAttackIfReady();
        }
    private:
        EventMap _events;
        uint8    _textCounter;
        ObjectGuid   _playerGUID;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_torturer_lecraftAI(creature);
    }
};

// 47447 - Corrosive Spit
class spell_dragonblight_corrosive_spit : public AuraScript
{
    PrepareAuraScript(spell_dragonblight_corrosive_spit);

    bool Validate(SpellInfo const* spellInfo) override
    {
        return ValidateSpellInfo({ uint32(spellInfo->GetEffect(EFFECT_0).CalcValue()) });
    }

    void AfterApply(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
    {
        if (GetTarget()->HasAura(aurEff->GetSpellInfo()->GetEffect(EFFECT_0).CalcValue()))
            GetAura()->Remove();
    }

    void PeriodicTick(AuraEffect const* aurEff)
    {
        if (GetTarget()->HasAura(aurEff->GetSpellInfo()->GetEffect(EFFECT_0).CalcValue()))
        {
            PreventDefaultAction();
            GetAura()->Remove();
        }
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_dragonblight_corrosive_spit::AfterApply, EFFECT_1, SPELL_AURA_PERIODIC_DAMAGE, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_dragonblight_corrosive_spit::PeriodicTick, EFFECT_1, SPELL_AURA_PERIODIC_DAMAGE);
    }
};

void AddSC_dragonblight()
{
    // Ours
    new npc_conversing_with_the_depths_trigger();
    new go_the_pearl_of_the_depths();
    new npc_hourglass_of_eternity();
    new npc_future_you();
    new npc_mindless_ghoul();
    new npc_injured_7th_legion_soldier();
    RegisterCreatureAI(npc_wintergarde_gryphon);
    RegisterSpellScript(spell_q12237_rescue_villager);
    RegisterSpellScript(spell_q12237_drop_off_villager);
    RegisterSpellScript(spell_call_wintergarde_gryphon);
    new npc_heated_battle();
    RegisterSpellScript(spell_q12478_frostmourne_cavern);
    RegisterSpellScript(spell_q12243_fire_upon_the_waters_aura);
    new npc_q24545_lich_king();
    new at_q24545_frostmourne_cavern();
    new npc_q24545_wretched_ghoul();
    RegisterSpellScript(spell_q24545_aod_special);
    new npc_q24545_vegard_dummy();
    new npc_q24545_vegard();
    new npc_spiritual_insight();

    // Theirs
    new npc_commander_eligor_dawnbringer();
    RegisterSpellScript(spell_q12096_q12092_dummy);
    RegisterSpellScript(spell_q12096_q12092_bark);
    new npc_torturer_lecraft();

    RegisterSpellScript(spell_dragonblight_corrosive_spit);
}
