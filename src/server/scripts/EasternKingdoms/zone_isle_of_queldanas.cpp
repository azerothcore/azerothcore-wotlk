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

#include "CreatureScript.h"
#include "PassiveAI.h"
#include "Pet.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellInfo.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
/* ScriptData
SDName: Isle_of_Queldanas
SD%Complete: 100
SDComment: Quest support: 11524, 11525, 11532, 11533, 11542, 11543, 11541
SDCategory: Isle Of Quel'Danas
EndScriptData */

/* ContentData
npc_converted_sentry
npc_greengill_slave
EndContentData */

/*###### OUR: ######*/

enum ThalorienNpcs
{
    NPC_THALORIEN_REMAINS = 37552,
    NPC_SUNWELL_DEFENDER = 37211,
    NPC_THALORIEN_KILL_CREDIT = 37601,
    NPC_MORLEN_COLDGRIP = 37542,
    NPC_SCOURGE_ZOMBIE = 37538,
    NPC_GHOUL_INVADER = 37539,
    NPC_CRYPT_RAIDER = 37541,
};

enum ThalorienEvents
{
    EVENT_NONE = 0,
    EVENT_CHECK_PLAYER,
    EVENT_SUMMON_SOLDIERS,
    EVENT_TALK_INTRO_0,
    EVENT_TALK_INTRO_1,
    EVENT_TALK_INTRO_2,
    EVENT_TALK_INTRO_3,
    EVENT_SALUTE,
    EVENT_SOLDIERS_RUN_AWAY,
    EVENT_GO_FIGHTPOINT,
    EVENT_TALK_SPAWN_0,
    EVENT_TALK_SPAWN_1,
    EVENT_SUMMON_MORLEN,
    EVENT_TALK_MORLEN_0,
    EVENT_TALK_MORLEN_1,
    EVENT_SPAWN_WAVE_1,
    EVENT_SPAWN_WAVE_2,
    EVENT_SPAWN_WAVE_3,
    EVENT_SUMMONS_ATTACK,
    EVENT_OUTRO_0,
    EVENT_OUTRO_1,
    EVENT_OUTRO_2,
    EVENT_OUTRO_3,
    EVENT_OUTRO_KNEEL,
    EVENT_DISAPPEAR,
    EVENT_SET_FACING,
    EVENT_SPELL_BLADESTORM,
    EVENT_SPELL_MORTAL_STRIKE,
    EVENT_SPELL_HEROIC_STRIKE,
};

enum ThalorienTexts
{
    SAY_INTRO_0 = 0,
    SAY_INTRO_1 = 1,
    SAY_INTRO_2 = 2,
    SAY_INTRO_3 = 3,
    SAY_SPAWN_0 = 4,
    SAY_SPAWN_1 = 5,
    SAY_MORLEN_0 = 0,
    SAY_MORLEN_1 = 1,
    SAY_MORLEN_2 = 2,
    SAY_MORLEN_3 = 3,
    SAY_MORLEN_4 = 4,
    SAY_OUTRO_0 = 6,
    SAY_OUTRO_1 = 7,
    SAY_OUTRO_2 = 8,
    SAY_OUTRO_3 = 9,
};

#define SUNWELL_DEFENDER_NUM 10
const Position SunwellDefenderPos[SUNWELL_DEFENDER_NUM] =
{
    {11801.6f, -7070.91f, 25.5347f, 2.7428f},
    {11800.8f, -7073.11f, 25.7903f, 2.78207f},
    {11799.9f, -7075.29f, 26.1329f, 2.78207f},
    {11799.1f, -7077.46f, 26.3211f, 2.78207f},
    {11798.1f, -7080.09f, 26.1556f, 2.78207f},
    {11795.1f, -7078.93f, 26.1822f, 2.77814f},
    {11796.0f, -7076.32f, 26.4659f, 2.79778f},
    {11797.0f, -7073.71f, 26.3534f, 2.79778f},
    {11797.8f, -7071.5f, 26.0573f, 2.79778f},
    {11798.7f, -7068.83f, 25.6424f, 2.79778f}
};

class npc_bh_thalorien_dawnseeker : public CreatureScript
{
public:
    npc_bh_thalorien_dawnseeker() : CreatureScript("npc_bh_thalorien_dawnseeker") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_bh_thalorien_dawnseekerAI(creature);
    }

    struct npc_bh_thalorien_dawnseekerAI : public ScriptedAI
    {
        npc_bh_thalorien_dawnseekerAI(Creature* c) : ScriptedAI(c), summons(me)
        {
        }

        EventMap events;
        SummonList summons;
        ObjectGuid playerGUID;
        ObjectGuid morlenGUID;

        void Reset() override
        {
            me->SetVisible(false);
            me->SetRegeneratingHealth(true);
            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_NONE);
            me->SetStandState(UNIT_STAND_STATE_STAND);
            playerGUID.Clear();
            morlenGUID.Clear();
            summons.DespawnAll();
            if (Creature* c = me->FindNearestCreature(NPC_THALORIEN_REMAINS, 100.0f, true))
                c->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
            events.Reset();
            events.ScheduleEvent(EVENT_CHECK_PLAYER, 5000);
            events.ScheduleEvent(EVENT_SUMMON_SOLDIERS, 0);
            events.ScheduleEvent(EVENT_TALK_INTRO_0, 3000);
            events.ScheduleEvent(EVENT_TALK_INTRO_1, 8000);
            events.ScheduleEvent(EVENT_TALK_INTRO_2, 15000);
            events.ScheduleEvent(EVENT_TALK_INTRO_3, 22000);
            events.ScheduleEvent(EVENT_SALUTE, 24000);
            events.ScheduleEvent(EVENT_SOLDIERS_RUN_AWAY, 30000);
            events.ScheduleEvent(EVENT_GO_FIGHTPOINT, 31000);
            events.ScheduleEvent(EVENT_TALK_SPAWN_0, 38000);
            events.ScheduleEvent(EVENT_SUMMON_MORLEN, 44000);
            events.ScheduleEvent(EVENT_TALK_SPAWN_1, 47000);
            events.ScheduleEvent(EVENT_TALK_MORLEN_0, 52000);
            events.ScheduleEvent(EVENT_TALK_MORLEN_1, 58000);
            events.ScheduleEvent(EVENT_SPAWN_WAVE_1, 61000);

            events.ScheduleEvent(EVENT_SPELL_BLADESTORM, urand(6000, 15000));
            events.ScheduleEvent(EVENT_SPELL_MORTAL_STRIKE, urand(3000, 7000));
            events.ScheduleEvent(EVENT_SPELL_HEROIC_STRIKE, urand(4000, 10000));
        }

        void JustSummoned(Creature* summon) override
        {
            summons.Summon(summon);
        }

        void SummonedCreatureDespawn(Creature* summon) override
        {
            summons.Despawn(summon);
            if (summon->GetEntry() != NPC_SUNWELL_DEFENDER && me->isActiveObject())
            {
                if (summon->GetEntry() == NPC_MORLEN_COLDGRIP)
                {
                    me->RemoveAurasDueToSpell(67541);
                    me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_NONE);
                    me->GetMotionMaster()->MoveCharge(11779.30f, -7065.43f, 24.92f, me->GetSpeed(MOVE_RUN), EVENT_CHARGE);
                    events.ScheduleEvent(EVENT_OUTRO_0, 0);
                    events.ScheduleEvent(EVENT_OUTRO_1, 5000);
                    events.ScheduleEvent(EVENT_OUTRO_2, 12000);
                    events.ScheduleEvent(EVENT_OUTRO_3, 19000);
                }
                else if (summons.size() == 1)
                {
                    me->RemoveAurasDueToSpell(67541);
                    me->GetMotionMaster()->MoveCharge(11779.30f, -7065.43f, 24.92f, me->GetSpeed(MOVE_RUN), EVENT_CHARGE);
                    switch (summon->GetEntry())
                    {
                        case NPC_SCOURGE_ZOMBIE:
                            events.ScheduleEvent(EVENT_SPAWN_WAVE_2, 3000);
                            break;
                        case NPC_GHOUL_INVADER:
                            events.ScheduleEvent(EVENT_SPAWN_WAVE_3, 3000);
                            break;
                        case NPC_CRYPT_RAIDER:
                            events.ScheduleEvent(EVENT_SUMMONS_ATTACK, 3000);
                            break;
                    }
                }
            }
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (damage >= me->GetHealth())
            {
                damage = 0;
                me->setActive(false);
                EnterEvadeMode(EVADE_REASON_OTHER);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!me->isActiveObject())
                return;

            UpdateVictim();

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (uint32 evId = events.ExecuteEvent())
            {
                case 0:
                    break;
                case EVENT_CHECK_PLAYER:
                    if (Player* p = ObjectAccessor::GetPlayer(*me, playerGUID))
                        if (p->GetExactDist(me) <= 50.0f)
                        {
                            events.RepeatEvent(5000);
                            break;
                        }
                    me->setActive(false);
                    EnterEvadeMode(EVADE_REASON_OTHER);
                    return;
                case EVENT_SUMMON_SOLDIERS:
                    for (uint8 i = 0; i < SUNWELL_DEFENDER_NUM; ++i)
                        me->SummonCreature(NPC_SUNWELL_DEFENDER, SunwellDefenderPos[i], TEMPSUMMON_TIMED_DESPAWN, 33000 + (i / 5) * 5000);
                    break;
                case EVENT_TALK_INTRO_0:
                case EVENT_TALK_INTRO_1:
                case EVENT_TALK_INTRO_2:
                case EVENT_TALK_INTRO_3:
                    Talk(SAY_INTRO_0 + (evId - EVENT_TALK_INTRO_0));
                    break;
                case EVENT_SALUTE:
                    me->HandleEmoteCommand(EMOTE_ONESHOT_SALUTE);
                    for (SummonList::const_iterator itr = summons.begin(); itr != summons.end(); ++itr)
                        if (Creature* c = ObjectAccessor::GetCreature(*me, *itr))
                            c->HandleEmoteCommand(EMOTE_ONESHOT_SALUTE);
                    break;
                case EVENT_SOLDIERS_RUN_AWAY:
                    {
                        uint8 count = 0;
                        for (SummonList::iterator itr = summons.begin(); itr != summons.end();)
                        {
                            ++count;
                            if (Creature* c = ObjectAccessor::GetCreature(*me, *itr))
                            {
                                c->SetWalk(false);
                                c->GetMotionMaster()->MovePoint(0, 11863.35f, -7073.44f, 27.40f);
                            }
                            SummonList::iterator itr2 = itr++;
                            summons.erase(itr2);
                            if (count >= 5)
                            {
                                if (!summons.empty())
                                {
                                    events.RepeatEvent(5000);
                                    return;
                                }
                                else
                                {
                                    return;
                                }
                            }
                        }
                    }
                    break;
                case EVENT_GO_FIGHTPOINT:
                    me->SetWalk(true);
                    me->GetMotionMaster()->MovePoint(0, 11779.30f, -7065.43f, 24.92f);
                    me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_READY2H);
                    break;
                case EVENT_TALK_SPAWN_0:
                case EVENT_TALK_SPAWN_1:
                    Talk(SAY_SPAWN_0 + (evId - EVENT_TALK_SPAWN_0));
                    break;
                case EVENT_SUMMON_MORLEN:
                    if (Creature* c = me->SummonCreature(NPC_MORLEN_COLDGRIP, 11766.70f, -7050.57f, 25.17f, 5.56f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000))
                        morlenGUID = c->GetGUID();
                    break;
                case EVENT_TALK_MORLEN_0:
                case EVENT_TALK_MORLEN_1:
                    if (Creature* c = ObjectAccessor::GetCreature(*me, morlenGUID))
                        c->AI()->Talk(SAY_MORLEN_0 + (evId - EVENT_TALK_MORLEN_0));
                    break;
                case EVENT_SPAWN_WAVE_1:
                case EVENT_SPAWN_WAVE_2:
                case EVENT_SPAWN_WAVE_3:
                    if (Creature* c = ObjectAccessor::GetCreature(*me, morlenGUID))
                    {
                        c->AI()->Talk(SAY_MORLEN_1 + (evId - EVENT_SPAWN_WAVE_1));
                        switch (evId)
                        {
                            // emerge cast tr false 66947
                            case EVENT_SPAWN_WAVE_1:
                                {
                                    Position spawnPos = c->GetPosition();
                                    spawnPos.SetOrientation(5.80f);
                                    spawnPos.m_positionX += 5.0f * cos(4.5f);
                                    spawnPos.m_positionY += 5.0f * std::sin(4.5f);
                                    for (uint8 i = 0; i < 5; ++i)
                                        if (me->SummonCreature(NPC_SCOURGE_ZOMBIE, spawnPos, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 2000))
                                        {
                                            spawnPos.m_positionX += 2.5f * cos(4.5f);
                                            spawnPos.m_positionY += 2.5f * std::sin(4.5f);
                                        }
                                }
                                break;
                            case EVENT_SPAWN_WAVE_2:
                                {
                                    Position spawnPos = c->GetPosition();
                                    spawnPos.SetOrientation(5.80f);
                                    spawnPos.m_positionX += 7.0f * cos(4.0f);
                                    spawnPos.m_positionY += 7.0f * std::sin(4.0f);
                                    for (uint8 i = 0; i < 3; ++i)
                                        if (Creature* s = me->SummonCreature(NPC_GHOUL_INVADER, spawnPos, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 2000))
                                        {
                                            s->CastSpell(s, 66947, false); // emerge effect
                                            spawnPos.m_positionX += 4.0f * cos(4.5f);
                                            spawnPos.m_positionY += 4.0f * std::sin(4.5f);
                                        }
                                }
                                break;
                            case EVENT_SPAWN_WAVE_3:
                                {
                                    Position spawnPos = c->GetPosition();
                                    spawnPos.SetOrientation(5.80f);
                                    spawnPos.m_positionX += 8.0f * cos(4.0f);
                                    spawnPos.m_positionY += 8.0f * std::sin(4.0f);
                                    for (uint8 i = 0; i < 3; ++i)
                                        if (Creature* s = me->SummonCreature(NPC_CRYPT_RAIDER, spawnPos, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 2000))
                                        {
                                            s->CastSpell(s, 66947, false); // emerge effect
                                            spawnPos.m_positionX += 4.0f * cos(4.5f);
                                            spawnPos.m_positionY += 4.0f * std::sin(4.5f);
                                        }
                                }
                                break;
                        }
                    }
                    events.ScheduleEvent(EVENT_SUMMONS_ATTACK, 3000);
                    break;
                case EVENT_SUMMONS_ATTACK:
                    for (SummonList::const_iterator itr = summons.begin(); itr != summons.end(); ++itr)
                        if (Creature* c = ObjectAccessor::GetCreature(*me, *itr))
                        {
                            if (c->GetEntry() == NPC_MORLEN_COLDGRIP && summons.size() != 1)
                                continue;
                            else
                                c->AI()->Talk(SAY_MORLEN_4);
                            c->SetImmuneToAll(false);
                            c->AI()->AttackStart(me);
                        }
                    break;
                case EVENT_OUTRO_0:
                case EVENT_OUTRO_1:
                case EVENT_OUTRO_2:
                case EVENT_OUTRO_3:
                    Talk(SAY_OUTRO_0 + (evId - EVENT_OUTRO_0));
                    if (evId == EVENT_OUTRO_3)
                        events.ScheduleEvent(EVENT_OUTRO_KNEEL, 6000);
                    break;
                case EVENT_OUTRO_KNEEL:
                    if (Player* p = ObjectAccessor::GetPlayer(*me, playerGUID))
                        p->KilledMonsterCredit(NPC_THALORIEN_KILL_CREDIT);
                    me->SetStandState(UNIT_STAND_STATE_KNEEL);
                    events.ScheduleEvent(EVENT_DISAPPEAR, 6000);
                    break;
                case EVENT_DISAPPEAR:
                    me->SetVisible(false);
                    me->setActive(false);
                    EnterEvadeMode(EVADE_REASON_OTHER);
                    break;
                case EVENT_SET_FACING:
                    me->SetFacingTo(2.45f);
                    break;

                case EVENT_SPELL_BLADESTORM:
                    if (me->GetVictim() && me->IsWithinMeleeRange(me->GetVictim()))
                        me->CastSpell(me->GetVictim(), 67541, false);
                    events.RepeatEvent(urand(25000, 35000));
                    break;
                case EVENT_SPELL_MORTAL_STRIKE:
                    if (me->GetVictim() && me->IsWithinMeleeRange(me->GetVictim()))
                        me->CastSpell(me->GetVictim(), 67542, false);
                    events.RepeatEvent(urand(7000, 12000));
                    break;
                case EVENT_SPELL_HEROIC_STRIKE:
                    if (me->GetVictim() && me->IsWithinMeleeRange(me->GetVictim()))
                        me->CastSpell(me->GetVictim(), 57846, false);
                    events.RepeatEvent(urand(5000, 10000));
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type == POINT_MOTION_TYPE && id == EVENT_CHARGE)
                events.ScheduleEvent(EVENT_SET_FACING, 0);
        }

        void EnterEvadeMode(EvadeReason why) override
        {
            if (me->isActiveObject())
                return;
            ScriptedAI::EnterEvadeMode(why);
        }

        void SetData(uint32 type, uint32 id) override
        {
            if (type == 1 && id == 1 && !me->isActiveObject())
                if (Player* p = me->SelectNearestPlayer(50.0f))
                {
                    me->SetVisible(true);
                    me->SetRegeneratingHealth(false);
                    me->setActive(true);
                    playerGUID = p->GetGUID();
                }
        }
    };
};

enum PurificationIds
{
    GO_QUEL_DELAR = 201794,
    NPC_SUNWELL_VISUAL_BUNNY = 37000,
    NPC_SUNWELL_HONOR_GUARD = 37781,
    NPC_ROMMATH = 37763,
    NPC_GALIROS = 38056,
    NPC_THERON = 37764,
    NPC_AURIC = 37765,
};

class spell_bh_cleanse_quel_delar : public SpellScript
{
    PrepareSpellScript(spell_bh_cleanse_quel_delar);

    void OnEffect(SpellEffIndex  /*effIndex*/)
    {
        if (Unit* caster = GetCaster())
            if (Creature* c = caster->FindNearestCreature(NPC_ROMMATH, 50.0f, true))
                c->AI()->DoAction(-1);
    }

    void Register() override
    {
        OnEffectLaunch += SpellEffectFn(spell_bh_cleanse_quel_delar::OnEffect, EFFECT_0, SPELL_EFFECT_SEND_EVENT);
    }
};

class npc_grand_magister_rommath : public CreatureScript
{
public:
    npc_grand_magister_rommath() : CreatureScript("npc_grand_magister_rommath") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_grand_magister_rommathAI(creature);
    }

    struct npc_grand_magister_rommathAI : public NullCreatureAI
    {
        npc_grand_magister_rommathAI(Creature* c) : NullCreatureAI(c)
        {
            announced = false;
            playerGUID.Clear();
            me->SetReactState(REACT_AGGRESSIVE);
        }

        EventMap events;
        bool announced;
        ObjectGuid playerGUID;

        void MoveInLineOfSight(Unit* who) override
        {
            if (!announced && who->IsPlayer() && who->GetPositionZ() < 30.0f)
            {
                announced = true;
                playerGUID = who->GetGUID();
                if (Creature* c = me->FindNearestCreature(NPC_GALIROS, 100.0f, true))
                    c->AI()->Talk(0, who);
            }
        }

        void DoAction(int32 a) override
        {
            if (a == -1 && !me->isActiveObject())
            {
                me->SummonGameObject(GO_QUEL_DELAR, 1688.24f, 621.769f, 29.1745f, 0.523177f, 0.0f, 0.0f, 0.0f, 0.0f, 86400);
                me->SummonCreature(NPC_SUNWELL_VISUAL_BUNNY, 1688.24f, 621.769f, 29.1745f, 0.523177f, TEMPSUMMON_MANUAL_DESPAWN);
                me->setActive(true);
                events.Reset();
                events.ScheduleEvent(1, 1000); // guard talk
                events.ScheduleEvent(2, 4000); // theron talk
                events.ScheduleEvent(3, 10000); // npcs walk
                events.ScheduleEvent(4, 17000); // rommath talk
                events.ScheduleEvent(5, 20000); // theron talk
                events.ScheduleEvent(6, 28000); // theron talk
                events.ScheduleEvent(7, 37000); // rommath talk
                events.ScheduleEvent(8, 44000); // rommath talk
                events.ScheduleEvent(9, 52000); // rommath talk
                events.ScheduleEvent(10, 60000); // auric talk
                events.ScheduleEvent(11, 66000); // auric talk
                events.ScheduleEvent(12, 76000); // rommath talk
                events.ScheduleEvent(13, 80000); // move home
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!me->isActiveObject())
                return;

            events.Update(diff);

            switch (events.ExecuteEvent())
            {
                case 1:
                    if (Creature* c = me->FindNearestCreature(NPC_SUNWELL_HONOR_GUARD, 60.0f, true))
                        c->AI()->Talk(0);
                    break;
                case 2:
                    if (Creature* c = me->FindNearestCreature(NPC_THERON, 60.0f, true))
                        c->AI()->Talk(0);
                    break;
                case 3:
                    me->SetWalk(true);
                    me->GetMotionMaster()->MovePath(me->GetEntry() * 100, false);
                    if (Creature* c = me->FindNearestCreature(NPC_THERON, 60.0f, true))
                    {
                        c->SetWalk(true);
                        c->GetMotionMaster()->MovePath(c->GetEntry() * 100, false);
                    }
                    if (Creature* c = me->FindNearestCreature(NPC_AURIC, 60.0f, true))
                    {
                        c->SetWalk(true);
                        c->GetMotionMaster()->MovePath(c->GetEntry() * 100, false);
                    }
                    break;
                case 4:
                    Talk(0);
                    break;
                case 5:
                    if (Creature* c = me->FindNearestCreature(NPC_THERON, 60.0f, true))
                        c->AI()->Talk(1);
                    break;
                case 6:
                    if (Creature* c = me->FindNearestCreature(NPC_THERON, 60.0f, true))
                        c->AI()->Talk(2, ObjectAccessor::GetPlayer(*me, playerGUID));
                    break;
                case 7:
                    Talk(1, ObjectAccessor::GetPlayer(*me, playerGUID));
                    break;
                case 8:
                    Talk(2);
                    break;
                case 9:
                    Talk(3);
                    break;
                case 10:
                    if (Creature* c = me->FindNearestCreature(NPC_AURIC, 60.0f, true))
                        c->AI()->Talk(0);
                    break;
                case 11:
                    if (Creature* c = me->FindNearestCreature(NPC_AURIC, 60.0f, true))
                        c->AI()->Talk(1);
                    break;
                case 12:
                    if (Player* p = ObjectAccessor::GetPlayer(*me, playerGUID))
                        Talk(p->GetTeamId() == TEAM_ALLIANCE ? 5 : 4, p);
                    break;
                case 13:
                    me->setActive(false);
                    if (Creature* c = me->FindNearestCreature(NPC_SUNWELL_VISUAL_BUNNY, 60.0f, true))
                        c->DespawnOrUnsummon(1);
                    if (GameObject* go = me->FindNearestGameObject(GO_QUEL_DELAR, 60.0f))
                        go->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                    me->SetWalk(true);
                    if (me->GetCreatureData())
                        me->GetMotionMaster()->MovePoint(0, me->GetCreatureData()->posX, me->GetCreatureData()->posY, me->GetCreatureData()->posZ);
                    if (Creature* c = me->FindNearestCreature(NPC_THERON, 60.0f, true))
                    {
                        c->SetWalk(true);
                        if (c->GetCreatureData())
                            c->GetMotionMaster()->MovePoint(0, c->GetCreatureData()->posX, c->GetCreatureData()->posY, c->GetCreatureData()->posZ);
                    }
                    if (Creature* c = me->FindNearestCreature(NPC_AURIC, 60.0f, true))
                    {
                        c->SetWalk(true);
                        if (c->GetCreatureData())
                            c->GetMotionMaster()->MovePoint(0, c->GetCreatureData()->posX, c->GetCreatureData()->posY, c->GetCreatureData()->posZ);
                    }
                    break;
            }
        }
    };
};

/*###### THEIR: ######*/

/*######
## npc_greengill_slave
######*/

#define ENRAGE  45111
#define ORB     45109
#define QUESTG  11541
#define DM      25060

class npc_greengill_slave : public CreatureScript
{
public:
    npc_greengill_slave() : CreatureScript("npc_greengill_slave") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_greengill_slaveAI(creature);
    }

    struct npc_greengill_slaveAI : public ScriptedAI
    {
        npc_greengill_slaveAI(Creature* creature) : ScriptedAI(creature) { }

        void JustEngagedWith(Unit* /*who*/) override { }

        void SpellHit(Unit* caster, SpellInfo const* spellInfo) override
        {
            Player* player = caster->ToPlayer();
            if (!player)
                return;

            if (spellInfo->Id == ORB && !me->HasAura(ENRAGE))
            {
                if (player->GetQuestStatus(QUESTG) == QUEST_STATUS_INCOMPLETE)
                    DoCast(player, 45110, true);

                DoCast(me, ENRAGE);

                if (Creature* Myrmidon = me->FindNearestCreature(DM, 70))
                {
                    me->AddThreat(Myrmidon, 100000.0f);
                    AttackStart(Myrmidon);
                }
            }
        }

        void UpdateAI(uint32 /*diff*/) override
        {
            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_isle_of_queldanas()
{
    // OUR:
    new npc_bh_thalorien_dawnseeker();
    RegisterSpellScript(spell_bh_cleanse_quel_delar);
    new npc_grand_magister_rommath();

    // THEIR:
    new npc_greengill_slave();
}
